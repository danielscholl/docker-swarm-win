# docker-swarm-win

This repository is a sample solution deploying IaaS neccessary for a Windows Swarm.

### Prerequisite

### Setup

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fdanielscholl%2Fdoc ker-win-swarm%2Fmaster%2Ftemplates%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

1. __Create a Resource Group__

```bash
az group create --location southcentralus --name docker-win-swarm
```

```powershell
Connect-AzureRMAccount

$ResourceGroupName = 'docker-win-swarm'
$Location = 'southcentralus'
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $Location
```

1. __Modify Template Parameters as desired__

1. __Deploy Template to Resource Group__

```bash
az group deployment create --name docker-win-swarm /
 --template-file azuredeploy.json /
 --parameters azuredeploy.parameters.json /
 --resource-group docker-win-swarm
```

```powershell
New-AzureRmResourceGroupDeployment -Name docker-win-swarm `
  -TemplateFile azuredeploy.json `
  -TemplateParameterFile azuredeploy.parameters.json `
  -ResourceGroupName $ResourceGroupName 
```

1. Initialize a Swarm

RDP into the vm0 and execute the following commands to initialize a Swarm Master.

```powershell
netsh advfirewall firewall add rule name="Open Port 2377" dir=in action=allow protocol=TCP localport=2377
netsh advfirewall firewall add rule name="Open Port 7946" dir=in action=allow protocol=TCP localport=7946
netsh advfirewall firewall add rule name="Open Port 7946" dir=in action=allow protocol=UDP localport=7946
netsh advfirewall firewall add rule name="Open Port 2377" dir=in action=allow protocol=UDP localport=4789

docker swarm init --advertise-addr=10.1.0.5 --listen-addr 10.1.0.5:2377
```

RDP into vm1 and execute the the following commands to join the worker to the swarm

```powershell
netsh advfirewall firewall add rule name="Open Port 2377" dir=in action=allow protocol=TCP localport=2377
netsh advfirewall firewall add rule name="Open Port 7946" dir=in action=allow protocol=TCP localport=7946
netsh advfirewall firewall add rule name="Open Port 7946" dir=in action=allow protocol=UDP localport=7946
netsh advfirewall firewall add rule name="Open Port 2377" dir=in action=allow protocol=UDP localport=4789

docker swarm join --token <your_token> 10.1.0.5:2377
```
