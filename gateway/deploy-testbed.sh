#!/usr/bin/env sh
set -eux

# Common environment variables (TB_PREFIX)
CDIR=$(dirname $0)
source ${CDIR}/common-env.sh

# Latest released 7.0 versions as of 2020-10-29
ESX_BUILD=ob-16850804
VCENTER_BUILD=ob-16860138
TB_SPEC=gateway/testbed-spec.rb

TB_DEPLOY=/mts/git/bin/nimbus-testbeddeploy
RESULTS_DIR=./tbdeploy-results-$(date -u +%Y%m%d-%H%M%S)

# Deploy a base infrastructure
${TB_DEPLOY} \
    --testbedSpecRubyFile ${TB_SPEC} \
    --runName ${TB_PREFIX} \
    --esxBuild ${ESX_BUILD} \
    --vcenterBuild ${VCENTER_BUILD} \
    --resultsDir ${RESULTS_DIR}
