#!/usr/bin/env sh
set -eux

NIMBUS_GATEWAY=FIXME_0

tar cvf gateway.tgz gateway/
scp gateway.tgz ${NIMBUS_GATEWAY}:
ssh ${NIMBUS_GATEWAY} "tar xvf gateway.tgz && gateway/deploy.sh"
