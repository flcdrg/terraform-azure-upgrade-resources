# Upgrading AzureRM resources

Demonstration of how to upgrade AzureRM resources - migrating from unsupported/deprecated resources to supported ones.

See [blog post](https://david.gardiner.net.au/2023/12/migrate-terraform-resources.html) for more information.

[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/3.0-upgrade-guide](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/3.0-upgrade-guide)

## Configure Terraform Cloud

1. Create a [Terraform Cloud](https://app.terraform.io) account
1. Create a new [Terraform Cloud API token](https://app.terraform.io/app/settings/tokens)
1. Create a new [Terraform Cloud workspace](https://app.terraform.io/app/organizations/new) linked to this GitHub repo
    1. Select "CLI-driven workflow"
    1. Enter workspace name `terraform-azure-upgrade`
    1. Click **Create**
1. Create an Azure resource group and a service principal with the Azure CLI

    ```bash
    az login
    az group create --location australiasoutheast --resource-group rg-tfupgrade-australiasoutheast
    az ad sp create-for-rbac --name sp-tfupgrade-australiasoutheast --role Contributor --scopes /subscriptions/<subscription_id>/resourceGroups/rg-tfupgrade-australiasoutheast
    ```

1. Add the following environment variables to your Terraform Cloud workspace:
    - `ARM_CLIENT_ID` - appId
    - `ARM_CLIENT_SECRET` - password (mark this as sensitive)
    - `ARM_SUBSCRIPTION_ID` - id from `az account show`
    - `ARM_TENANT_ID`

1. Run `terraform login`
1. Paste the token from the browser session into the terminal
1. Run `terraform init` to initialise the workspace locally
