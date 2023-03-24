param vnetName string
param vnetAddressPrefix string

param subnetName string
param subnetAddressPrefix string
param subnetServiceEndpointService string

param location string

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
          privateEndpointNetworkPolicies: 'Disabled'
          serviceEndpoints: [
            {
              locations: [
                'West Europe'
              ]
              service: subnetServiceEndpointService
            }
          ]
        }
      }
    ]
  }
}
