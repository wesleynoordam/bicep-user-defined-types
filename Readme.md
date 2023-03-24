# Bicep complex objects - User Defined Types
This repository contains different bicep modules to deploy a vnet resource. Different types of setup are:
- Plain parameter lists
- Object parameters
- User defined types

Use the different code blocks below in `azuredeploy.bicep` to start playing around.

## Module 1 - Simple parameters types

```bicep
module module1 '1-vnet-module-different-parameters.bicep' = {
  name: 'module1'
  params: {
    location: location
    vnetName: 'betatalks-vnet'
    vnetAddressPrefix: '10.0.0.0/20'
    subnetName: 'default'
    subnetAddressPrefix: '10.0.0.0/24'
    subnetServiceEndpointService: 'Microsoft.Sql'
  }
}
```

## Module 2 - Objects

```bicep
module module2 '2-vnet-module-object.bicep' = {
  name: 'module2'
  params: {
    location: location
    vnetSettings: {
      value: {
        name: 'betatalks-vnet'
        addressPrefix: '10.0.0.0/20'
        subnets: [
          {
            name: 'default'
            addressPrefix: '10.0.0.0/24'
            serviceEndpoints: [
              {
                locations: [ 'West Europe' ]
                service: 'Microsoft.Sql'
              }
            ]
            delegations: []
          }
          {
            name: 'app-service-plan'
            addressPrefix: '10.0.1.0/24'
            serviceEndpoints: []
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
    }
  }
}
```

## Module 3 - User defined types

```json bicepconfig.json
{
  "experimentalFeaturesEnabled": {
    "userDefinedTypes": true
  }
}
```

```bicep
module module3 '3-vnet-module-user-defined-types.bicep' = {
  name: 'module3'
  params: {
    location: location
    vnetSettings: {
      name: 'betatalks-vnet'
      addressPrefix: '10.0.0.0/20'
      subnets: [
        {
          name: 'default'
          addressPrefix: '10.0.0.0/24'
          serviceEndpoints: [
            {
              locations: [ 'West Europe' ]
              service: 'Microsoft.Sql'
            }
          ]
        }
        {
          name: 'app-service-plan'
          addressPrefix: '10.0.1.0/24'
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
  }
}

```

## Future of types
https://gist.github.com/jeskew/fc075f7a163fe021b42ca2c190d5383c#a-typeof-keyword-or-function