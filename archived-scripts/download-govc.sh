#!/usr/bin/env sh
set -eux

GOVC_URL=https://github.com/vmware/govmomi/releases/download/v0.23.0/govc_linux_amd64.gz
GOVC_SHA1=ba777988af807e4a9aaea47339125f15cdbc8eea

echo "${GOVC_SHA1}  govc.gz" > govc.sha1
wget --quiet --output-document govc.gz ${GOVC_URL}
sha1sum --check govc.sha1
gzip -d govc.gz
chmod +x govc

