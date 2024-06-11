param aksClusterName string
param location string = resourceGroup().location
param kubernetesVersion string = '1.24.6'

@description('Agent pool name')
param agentPoolName string = 'nodepool1'

@description('VM size for the agent pool')
param vmSize string = 'Standard_DS2_v2'

@description('Number of agent nodes')
param nodeCount int = 1

resource aksCluster 'Microsoft.ContainerService/managedClusters@2022-10-01' = {
  name: Myakscluster
  location: EastUS
  properties: {
    kubernetesVersion: kubernetesVersion
    agentPoolProfiles: [
      {
        name: agentPoolName
        count: nodeCount
        vmSize: vmSize
        mode: 'System'
      }
    ]
    dnsPrefix: aksClusterName
    enableRBAC: true
    networkProfile: {
      networkPlugin: 'azure'
    }
  }
}

output aksClusterName string = aksCluster.name
output kubernetesVersion string = aksCluster.properties.kubernetesVersion
output nodeCount int = aksCluster.properties.agentPoolProfiles[0].count
