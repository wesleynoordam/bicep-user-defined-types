@metadata({
  value: {
    name: 'vnet-name'
    addressPrefix: '10.0.0.0/22'
    subnets: [
      {
        name: 'default'
        addressPrefix: '10.0.0.0/24'
        serviceEndpoints: [
          {
            locations: [
              'West Europe'
            ]
            service: 'Microsoft.Sql'
          }
        ]
        delegations: [
          {
            name: 'Microsoft.Web/serverFarms'
            properties: {
              serviceName: 'Microsoft.Web/serverFarms'
            }
          }
        ]
      }
    ]
  }
})
param vnetSettings object

param location string

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetSettings.name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetSettings.addressPrefix
      ]
    }
    subnets: [for subnet in vnetSettings.subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix
        privateEndpointNetworkPolicies: 'Disabled'
        serviceEndpoints: subnet.serviceEndpoints ?? []
        delegations: subnet.delegations ?? []
      }
    }]
  }
}
