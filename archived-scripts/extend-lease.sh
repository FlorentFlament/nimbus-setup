#!/usr/bin/env sh
set -eux

# Common environment variables (TB_PREFIX and NIMBUS)
CDIR=$(dirname $0)
source ${CDIR}/common-env.sh

# Extend infrastructure lease to 7 days (instead of 1 day)
${NIMBUS} ctl extend_lease \
          --lease=7 \
          ${USER}-${TB_PREFIX}.vc.0 \
          ${USER}-${TB_PREFIX}.esx.0 \
          ${USER}-${TB_PREFIX}.worker.0
