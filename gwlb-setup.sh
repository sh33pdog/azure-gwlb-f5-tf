#create GWLB using AZ CLI. This will be updated when the Terraform provider supports the Azure Gateway Load Balancer (current latest version 2.78.0 does not support this yet)

#variables
rgName='my-demo-resource-group' 
gwlb_name='MyGatewayLoadBalancer'
publicLBName='MyPublicLoadBalancer'
vnetName='my-demo-resource-group-provider-vnet' # this should be the provider VNet, ie., the VNET in which the firewall is deployed.
frontendIPNameGW='myGWLBFrontEnd'
frontendIPNamePublicLB='myFrontEnd'             # name of frontend configuration of public LB
publicIPName='MyPublicIP'                       # name of public IP object
healthProbeName='httpProbe80'

f5vm_ext_nic_name='bigip-2242-ext-nic-public-0'
ipconfig_name='bigip-2242-ext-public-ip-0'
f5vm_ext_nic_name1='bigip-841d-ext-nic-public-0'
ipconfig_name1='bigip-841d-ext-public-ip-0'

#create GWLB
az network lb create -g $rgName -n $gwlb_name --sku Gateway --vnet-name $vnetName --subnet external --frontend-ip-name $frontendIPNameGW --backend-pool-name myBackendPool
az network lb probe create -g $rgName --lb-name $gwlb_name --name $healthProbeName --protocol http --port 80 --path /healthcheck
az network lb address-pool tunnel-interface add -g $rgName --lb-name $gwlb_name --address-pool myBackendPool --type external --protocol vxlan --identifier 801 --port 2001
az network lb address-pool tunnel-interface update -g $rgName --lb-name $gwlb_name --address-pool myBackendPool --index 0 --type internal --protocol vxlan --identifier 802 --port 2002
az network lb rule create -g $rgName --lb-name $gwlb_name --name myHTTPRule --protocol all --frontend-port 0 --backend-port 0 --frontend-ip-name $frontendIPNameGW --backend-pool-name myBackendPool --probe-name $healthProbeName --disable-outbound-snat true

#add BIG-IP devices to backend pool of GWLB
az network nic ip-config address-pool add --nic-name $f5vm_ext_nic_name -n $ipconfig_name --lb-name $gwlb_name --address-pool myBackendPool -g $rgName
az network nic ip-config address-pool add --nic-name $f5vm_ext_nic_name1 -n $ipconfig_name1 --lb-name $gwlb_name --address-pool myBackendPool -g $rgName

#now update Standard LB frontend IP to point to GWLB frontend IP
resourceId=$(az network lb show -g $rgName -n $gwlb_name | jq -r .frontendIpConfigurations[].id)
az network lb frontend-ip update -g $rgName --lb-name $publicLBName -n $frontendIPNamePublicLB --public-ip-address $publicIPName --gateway-lb $resourceId

