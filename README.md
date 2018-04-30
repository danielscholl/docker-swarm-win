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

Windows Swarm Mode [Documentation](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/swarm-mode)


The loadbalancer Public IP Address is used to RDP into the Servers.

Example:
<ip>:5000 -- vm0
<ip>:5001 -- vm1


_Swarm Master Init Example_
```bash
$IP=((ipconfig | findstr [0-9].\.)[0]).Split()[-1]
docker swarm init --advertise-addr=${IP} --listen-addr ${IP}:2377

# Example Result
Swarm initialized: current node (iin85eksly3485m7m26ij7var) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token <your_token> 10.1.0.4:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

_Swarm Worker Join Example_
```bash
docker swarm join --token <your_token> 10.1.0.4:2377
```
