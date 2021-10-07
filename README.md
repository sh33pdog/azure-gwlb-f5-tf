# azure-gwlb-f5-tf
Deploys Azure Gateway Load Balancer and F5 BIG-IP using Terraform

## Instructions

### Deploy this demo
Because the Terraform provider has not been updated for the new Azure Gateway Load Balancer type (as of Oct 2021), we will deploy most of our infrastructure with Terraform, but then the final updates will be made via Azure CLI.
````
git clone https://github.com/mikeoleary/azure-gwlb-f5-tf.git
cd azure-gwlb-f5-tf
terraform init
terraform plan
terraform apply -auto-approve
````
Most of our infrastructure is now deployed, but we must run the following script to create our GWLB and update our existing public LB to reference it.
````
. gwlb-setup.sh
````

### Verify your deployment
1. Find the output called "application_url". This is output at the end of deployment, or you can determine it again with this command
````
terraform output
````
2. Visit this URL in your browser. You should see a demo web app. This traffic is flowing via a Web App Firewall (WAF).

### Delete this demo
First, we will need to delete the GWLB we created with our script earlier.
````
. gwlb-destroy.sh
````
Then we can use Terraform to destroy the remaining infrastructure.
````
terraform destroy -auto-approve
#clean up the demo
cd ..
rm -rf azure-gwlb-f5-tf
````

## Prerequisites
This demo was created with Terraform version 1.0.5
The below providers were tested and working with the following version
Terraform 1.0.5
* provider registry.terraform.io/hashicorp/azurerm v2.79.1
* provider registry.terraform.io/hashicorp/null v3.1.0
* provider registry.terraform.io/hashicorp/template v2.2.0
* provider registry.terraform.io/hashicorp/random v3.1.0
* provider registry.terraform.io/hashicorp/tls v3.1.0
* This solution requires an Azure account that can provision objects described in the solution.
* This solution requires you to accept any Azure Marketplace "License/Terms and Conditions" for the images used in this solution.
  * By Default, this solution uses f5-bigip-virtual-edition-200m-best-hourly
  * Azure CLI:
    ````
    az vm image terms accept --urn f5-networks:f5-big-ip-best:f5-bigip-virtual-edition-200m-best-hourly:latest"
    ````
* az cli installed and authenticated
