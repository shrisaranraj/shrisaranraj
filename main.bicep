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

targetScope = 'Tenant Root Group'

param mgName string = 'mg-${uniqueString(newGuid())}'

resource newMG 'Microsoft.Management/managementGroups@2020-05-01' = {
  scope: tenant()
  name: mgName
  properties: {
    details: {
      parent: {
        id: managementGroup().id
      }
    }
  }
}

output storageEndpoint object = stg.properties.primaryEndpoints
output newManagementGroup string = mgName
