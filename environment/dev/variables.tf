variable "subnet" {
  default = {
    subnet1 = {
      cidr                                           = "192.168.1.0/24",
      nsg                                            = "nsg1",
      delegation                                     = [],
      enforce_private_link_endpoint_network_policies = false,
      enforce_private_link_service_network_policies  = false,
      endpoints                                      = ["Microsoft.AzureActiveDirectory", "Microsoft.Sql", "Microsoft.KeyVault", "Microsoft.Storage"]
    }
    subnet2 = {
      cidr                                           = "192.168.2.0/24",
      nsg                                            = "nsg2",
      enforce_private_link_endpoint_network_policies = true,
      enforce_private_link_service_network_policies  = true,
      delegation = [
        { name            = "delegation1",
          service-name    = "Microsoft.Web/serverFarms",
          service-actions = ["Microsoft.Network/virtualNetworks/subnets/action"],
        }
      ]
      endpoints = ["Microsoft.AzureActiveDirectory", "Microsoft.AzureCosmosDB", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.Web", ]
    }
    subnet3 = {
      cidr                                           = "192.168.3.0/24",
      nsg                                            = "",
      enforce_private_link_endpoint_network_policies = false,
      enforce_private_link_service_network_policies  = false,
      delegation                                     = []
      endpoints                                      = []
    }

  }
}


variable "nsgs" {
  default = {
    nsg1 = []
    nsg2 = [
      {
        access                                     = "Allow",
        description                                = "",
        destination_address_prefix                 = "10.1.0.0/16",
        destination_address_prefixes               = [],
        destination_application_security_group_ids = [],
        destination_port_range                     = "*",
        destination_port_ranges                    = [],
        direction                                  = "Outbound",
        name                                       = "Outbound1",
        priority                                   = 110,
        protocol                                   = "*",
        source_address_prefix                      = "192.168.1.0/24",
        source_address_prefixes                    = [],
        source_application_security_group_ids      = [],
        source_port_range                          = "*",
        source_port_ranges                         = [],
      },
      {
        access                                     = "Allow",
        description                                = "",
        destination_address_prefix                 = "192.168.1.0/24",
        destination_address_prefixes               = [],
        destination_application_security_group_ids = [],
        destination_port_range                     = "22",
        destination_port_ranges                    = [],
        direction                                  = "Inbound",
        name                                       = "sshinbound",
        priority                                   = 110,
        protocol                                   = "*",
        source_address_prefix                      = "*",
        source_address_prefixes                    = [],
        source_application_security_group_ids      = [],
        source_port_range                          = "*",
        source_port_ranges                         = [],
      }
    ]
  }
}
