#destroy GWLB using AZ CLI. This will be updated when the Terraform provider supports the Azure Gateway Load Balancer (current latest version 2.78.0 does not support this yet)

#variables
rgName='my-demo-resource-group' 
gwlb_name='MyGatewayLoadBalancer'
publicLBName='MyPublicLoadBalancer'

#destroy GWLB
az network lb delete -g $rgName -n $gwlb_name 

#now destroy Standard LB because TF will complain on destroy if it is referencing a non-existant gwlb
az network lb delete -g $rgName -n $publicLBName

