# Deploys a base infrastructure:
# * 1 ESX (16 vCPUs, 128 GB RAM, 1 TB disk)
# * 1 vCenter
# * 1 worker

gb2mb = 1024
gb2kb = 1024**2

$testbed = Proc.new do
  {
    "name" => "base-testbed",
    "version" => 4,

    "vcs" => [
      {
        "name" => "vc0",
        "type" => "vcva",
        "clusterName" => "Cluster",
        "dcName" => ["Datacenter"],
        "clusters" => [
          {
            "name" => "Cluster",
            "dc" => "Datacenter",
          },
        ],
      },
    ],

    "esx" => [
      {
        "name" => "esx0",
        "style" => "fullInstall",
        "cpus" => 16,
        "memory" => 128*gb2mb, # 128 GB (in MB)
        # Beware, first disk is used for system and will always be 32 GB
        # If 0 it is discarded ...
        "disk" => [ 1, 1024*gb2kb], # 1 TB (in KB)
        "vc" => "vc0",
        "dc" => "Datacenter",
        "clusterName" => "Cluster",
      },
    ],

    "worker" => [
      {
        "name" => "worker0",
        "enableStaticIpService" => true,
      },
    ],

    "beforePostBoot" => Proc.new do |runId, testbedSpec, vmList, catApi, logDir|
    end,
    "postBoot" => Proc.new do |runId, testbedSpec, vmList, catApi, logDir|
    end,
  }
end
