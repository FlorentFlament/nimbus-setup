#!/usr/bin/env sh
set -eux

# govc host vCenter related environment variables
CDIR=$(dirname $0)
source ${CDIR}/common-env.sh

# Could not find better ...
VCENTER_IP=$(${NIMBUS} ctl ip ${USER}-${TB_PREFIX}.vc.0 | tail -1 | awk '{print $3}')
source ${CDIR}/govc-host-env.sh

UBUNTU_OVA=https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.ova
JUMPBOX_SPEC=gateway/jumpbox-spec.json

./govc import.ova -options ${JUMPBOX_SPEC} ${UBUNTU_OVA}
# Add a 50 GB disk to the jumpbox
./govc vm.disk.create -vm jbox -name jbox/space.vmdk -size 50G
