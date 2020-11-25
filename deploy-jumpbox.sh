#!/bin/bash
set -eu

# NP_* environment variables can be defined in the following
# configuration file. Beware, this file will override any environment
# variables set in the shell.
CONFIG_FILE="${HOME}/.np-jumpbox.conf"
if [ -f ${CONFIG_FILE} ]; then
    echo "Using ${CONFIG_FILE} configuration file."
    . ${CONFIG_FILE}
fi

# govc configuration
export GOVC_URL=${NP_VCENTER_IP:?}
export GOVC_USERNAME=${NP_VCENTER_USERNAME:?}
export GOVC_PASSWORD=${NP_VCENTER_PASSWORD:?}
export GOVC_INSECURE=${NP_VCENTER_INSECURE:="true"}

# vSphere resources to use
export GOVC_DATACENTER=${NP_VSPHERE_DATACENTER:?}
export GOVC_DATASTORE=${NP_VSPHERE_DATASTORE:?}
: ${NP_VSPHERE_NETWORK:?} # vSphere network to connect the jumpbox to

# Jumpbox credentials
: ${NP_JUMPBOX_PUBKEY:?}
: ${NP_JUMPBOX_TEMP_PASSWORD:="changeme"} # This has to be changed at first login
: ${NP_JUMPBOX_OVA:="https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.ova"}

echo "Using the following parameters:"
for v in NP_VCENTER_IP NP_VCENTER_USERNAME NP_VCENTER_INSECURE NP_VSPHERE_DATACENTER NP_VSPHERE_DATASTORE NP_VSPHERE_NETWORK NP_JUMPBOX_PUBKEY NP_JUMPBOX_OVA; do
    echo "${v}: ${!v}"
done
echo ""

SPEC_FILE=$(cat <<EOF
{
    "Name": "jbox",
    "DiskProvisioning": "flat",
    "IPAllocationPolicy": "dhcpPolicy",
    "IPProtocol": "IPv4",
    "PropertyMapping": [
        {
            "Key": "instance-id",
            "Value": "jbox"
        },
        {
            "Key": "hostname",
            "Value": "jbox"
        },
        {
            "Key": "public-keys",
            "Value": "${NP_JUMPBOX_PUBKEY}"
        },
        {
            "Key": "password",
            "Value": "${NP_JUMPBOX_TEMP_PASSWORD}"
        }
    ],
    "NetworkMapping": [
        {
            "Name": "VM Network",
            "Network": "${NP_VSPHERE_NETWORK}"
        }
    ],
    "PowerOn": true
}
EOF
)

govc import.ova -options <(echo "${SPEC_FILE}") ${NP_JUMPBOX_OVA}
# Add a 50 GB disk to the jumpbox
govc vm.disk.create -vm jbox -name jbox/space.vmdk -size 50G
