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

var managementGroupName = 'fadvtstmgmt01'

resource stg 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: uniqueStorageName
  location: location
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
  tags:{
        Name: 'owner'
        value: 'Saranraj'
  }
}

resource stg 'Microsoft.Management/managementGroups@2021-08-01' = {
  name: managementGroupName
  scope: tenant()
  properties: {
    details: {
      parent: {
        id: 'string'
      }
    }
    displayName: 'string'
  }
}

output storageEndpoint object = stg.properties.primaryEndpoints
