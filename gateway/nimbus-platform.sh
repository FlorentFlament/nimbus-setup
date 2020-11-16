#!/bin/bash
set -eu

# Standalone script to deploy a vSphere platform on Nimbus composed by:
# * 1 ESX
# * 1 vCenter
# * 1 worker (to allocate static IPs)

# NP_* environment variables can be defined in the following
# configuration file. Beware, this file will override any environment
# variables set in the shell.
CONFIG_FILE="${HOME}/.nimbus-platform.conf"
if [ -f ${CONFIG_FILE} ]; then
    echo "Using ${CONFIG_FILE} configuration file."
    . ${CONFIG_FILE}
fi

# NP_NAME is required
: ${NP_NAME:?}

# Other environment variables have the following defaults
: ${NP_ESX_BUILD:=ob-16850804}
: ${NP_VCENTER_BUILD:=ob-16860138}
: ${NP_CPU:=2}
: ${NP_RAM:=16}
: ${NP_DISK:=32}

echo "Using the following parameters:"
for v in NP_NAME NP_ESX_BUILD NP_VCENTER_BUILD NP_CPU NP_RAM NP_DISK; do
    echo "${v}: ${!v}"
done

TB_DEPLOY=/mts/git/bin/nimbus-testbeddeploy
RESULTS_DIR=./tbdeploy-results-$(date -u +%Y%m%d-%H%M%S)

TB_SPEC=$(
    cat <<EOF
\$testbed = Proc.new do
  {
    "name" => "${NP_NAME}",
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
        "cpus" => ${NP_CPU},
        "memory" => ${NP_RAM} *1024, # 128 GB (in MB)
        # Beware, first disk is used for system and will always be 32 GB
        # If 0 it is discarded ...
        "disk" => [ 1, ${NP_DISK} *1024**2], # 1 TB (in KB)
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
EOF
    )

# Note that `nimbus-testbeddeploy` doesn't support having the
# `testbedSpecRubyFile` provided as a named pipe. So using a temporary
# file.
SPEC_FILE=$(mktemp)
echo "${TB_SPEC}" >${SPEC_FILE}

echo "Launching ${TB_DEPLOY} with ${SPEC_FILE} spec file..."
${TB_DEPLOY} \
   --testbedSpecRubyFile ${SPEC_FILE} \
   --runName ${NP_NAME} \
   --esxBuild ${NP_ESX_BUILD} \
   --vcenterBuild ${NP_VCENTER_BUILD} \
   --resultsDir ${RESULTS_DIR}

rm ${SPEC_FILE}
