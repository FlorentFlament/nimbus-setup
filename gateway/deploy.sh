#!/usr/bin/env sh
set -eux

CDIR=$(dirname $0)

${CDIR}/download-govc.sh
${CDIR}/nimbus-platform.sh
${CDIR}/extend-lease.sh
${CDIR}/deploy-jumpbox.sh
