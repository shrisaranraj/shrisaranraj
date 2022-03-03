# Create virtual machine

resource "azurerm_resource_group" "compute" {
    name     = "${var.rg_name}"
    location = "East US 2"
}

resource "azurerm_network_interface" "vm_nic" {
    name                      = "nic-${var.runner_name}"
    location                  = "East US 2"
    resource_group_name       = azurerm_resource_group.compute.name

    ip_configuration {
        name                          = "nic-profile-${var.runner_name}"
        subnet_id                     = data.azurerm_subnet.vm.id
        private_ip_address_allocation = "Dynamic"
    }

    tags = var.tags
}

# Create an SSH key
resource "tls_private_key" "vm_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "azurerm_linux_virtual_machine" "ghrunner" {
    name                  = var.runner_name
    location              = var.azlocation
    resource_group_name   = azurerm_resource_group.compute.name
    network_interface_ids = [azurerm_network_interface.vm_nic.id]
    size                  = var.vm_size

    os_disk {
        name              = "disk-os-${var.runner_name}"
        caching           = "ReadWrite"
        storage_account_type = var.disk_type
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-focal"
        sku       = "20_04-lts-gen2"
        version   = "latest"
    }
    
    identity {
      type = "SystemAssigned"
    }

    computer_name  = var.runner_hname
    admin_username = "azureuser"
    disable_password_authentication = true
    custom_data = base64encode(
        templatefile(
            var.runner_script, 
            {
                ghtoken = var.runner_token
                runnerversion = var.runner_version
                shrhname = var.runner_hname
            }
        )
    )

    admin_ssh_key {
        username       = "azureuser"
        public_key     = tls_private_key.vm_ssh.public_key_openssh
    }

    tags = var.tags
}