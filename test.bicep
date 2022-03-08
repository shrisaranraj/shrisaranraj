resource symbolicname 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: 'testpresidio'
  scope: tenant()
  properties: {
    details: {
      parent: {
        id: 'Tenant Root Group'
      }
    }
    displayName: 'test'
  }
}
