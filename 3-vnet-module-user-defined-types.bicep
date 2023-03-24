param vnetSettings vnetSetting

type vnetSetting = {
  name: string
  @description('Address range in CIDR notation')
  addressPrefix: string
  subnets: subnetSetting[]
}
type subnetSetting = {
  name: string
  addressPrefix: string
  serviceEndpoints: serviceEndpointSetting[]?
  delegations: delegationSetting[]?
}
type serviceEndpointSetting = {
  locations: string[]
  @description('Services which are allowed to be used. For example \'Microsoft.Sql\' or \'Microsoft.KeyVault\'')
  service: string
}
type delegationSetting = {
  @description('The name of the resource that is unique within a subnet. This name can be used to access the resource.')
  name: string
  properties: {
    @description('Service type for which a subnet is delegated to. For example \'Microsoft.Web/serverFarms\' or \'Microsoft.ApiManagement/service\'')
    serviceName: string
  }
}

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
