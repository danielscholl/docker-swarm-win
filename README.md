# docker-swarm-win

This repository is a sample solution deploying IaaS neccessary for a Windows Swarm.

### Automatic Deploy

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fdanielscholl%2Fdocker-swarm-win%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

### PowerShell Deploy

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

### Initialize a Swarm

[Documentation](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/swarm-mode)

RDP into the Master Node (vm0) and execute the following commands to initialize a Swarm Master.

Example
```powershell
docker swarm init --advertise-addr=10.1.0.5 --listen-addr 10.1.0.5:2377
```

RDP into Worker Nodes (vm1) and execute the the following commands to join the worker to the swarm

Example
```powershell
docker swarm join --token <your_token> 10.1.0.5:2377
```
