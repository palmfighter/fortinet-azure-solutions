##############################################################################################################
#
# FortiManager Single VM - 1 NIC
# Terraform deployment template for Microsoft Azure
#
##############################################################################################################

# Prefix for all resources created for this deployment in Microsoft Azure
variable "PREFIX" {
  description = "Added name to each deployed resource"
}

variable "LOCATION" {
  description = "Azure region"
}

variable "USERNAME" {
}

variable "PASSWORD" {
}

##############################################################################################################
# FortiGate license type
##############################################################################################################

variable "FMG_IMAGE_SKU" {
  description = "Azure Marketplace default image sku hourly (PAYG 'fortinet_fg-vm_payg_20190624') or byol (Bring your own license 'fortinet_fg-vm')"
  default     = "fortinet-fortimanager"
}

variable "FMG_VERSION" {
  description = "FortiGate version by default the 'latest' available version in the Azure Marketplace is selected"
  default     = "6.2.3"
}

variable "FMG_BYOL_LICENSE_FILE_A" {
  default = ""
}

variable "FMG_SSH_PUBLIC_KEY_FILE" {
  default = ""
}

##############################################################################################################
# Microsoft Azure Storage Account for storage of Terraform state file
##############################################################################################################

terraform {
  required_version = ">= 0.12"
}

##############################################################################################################
# Deployment in Microsoft Azure
##############################################################################################################

provider "azurerm" {
  version = ">= 2.0.0"
  features {}
}

##############################################################################################################
# Static variables
##############################################################################################################

variable "vnet" {
  description = ""
  default     = "172.16.136.0/22"
}

variable "subnet" {
  type        = map(string)
  description = ""

  default = {
    "1" = "172.16.137.0/24"  # FMG network
  }
}

variable "subnetmask" {
  type        = map(string)
  description = ""

  default = {
    "1" = "24" # FMG network
  }
}

variable "fmg_ipaddress_a" {
  type        = map(string)
  description = ""

  default = {
    "1" = "172.16.136.5"  # FMG network
  }
}

variable "gateway_ipaddress" {
  type        = map(string)
  description = ""

  default = {
    "1" = "172.16.137.1"  # FMG network
  }
}

variable "fmg_vmsize" {
  default = "Standard_D2s_v3"
}

##############################################################################################################
# Resource Group
##############################################################################################################

resource "azurerm_resource_group" "resourcegroup" {
  name     = "${var.PREFIX}-RG"
  location = var.LOCATION
}

##############################################################################################################