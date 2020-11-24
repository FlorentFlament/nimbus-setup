#!/usr/bin/env sh
set -eux

VMWARE_PRODUCTS_DIR=/mnt/ubuntu/vmware-products

NESTED_ESX=https://download3.vmware.com/software/vmw-tools/nested-esxi/Nested_ESXi7.0u1_Appliance_Template_v1.ova
VCSA_ISO=FIXME_8

mkdir -p ${VMWARE_PRODUCTS_DIR}

for PRODUCT in ${NESTED_ESX} ${VCSA_ISO}; do
    wget \
        --directory-prefix ${VMWARE_PRODUCTS_DIR} \
        ${PRODUCT}
done
