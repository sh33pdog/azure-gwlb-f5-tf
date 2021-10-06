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
````
terraform destroy -auto-approve
#clean up the demo
cd ..
rm -rf azure-gwlb-f5-tf
````

## Requirements
- terraform version ~> 1.0.5
- az cli installed and authenticated