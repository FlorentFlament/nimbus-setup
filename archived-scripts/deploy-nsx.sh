#!/usr/bin/env sh
set -eux

# govc host vCenter related environment variables
CDIR=$(dirname $0)
source ${CDIR}/common-env.sh

# Could not find better ...
VCENTER_IP=$(${NIMBUS} ctl ip ${USER}-${TB_PREFIX}.vc.0 | tail -1 | awk '{print $3}')
source ${CDIR}/govc-host-env.sh

NSX_OVA=FIXME_1
NSX_SPEC=gateway/nsx-spec.json

./govc import.ova -options ${NSX_SPEC} ${NSX_OVA}
