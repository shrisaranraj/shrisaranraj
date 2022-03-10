@minLength(3)
@maxLength(11)
param storagePrefix string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageSKU string = 'Standard_LRS'

param location string = resourceGroup().location

var uniqueStorageName = '${storagePrefix}${uniqueString(resourceGroup().id)}'

resource stg 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: uniqueStorageName
  location: location
  tags:{
        Owner: 'Saranraj'
  }
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

targetScope = 'managementGroup'

param otherManagementGroupName string = 'Tenant Root Group'

// module deployed at management group level but in a different management group
module exampleModule 'module.bicep' = {
  name: 'test'
  scope: managementGroup(otherManagementGroupName)
}

output storageEndpoint object = stg.properties.primaryEndpoints
output newManagementGroup string = mgName

