This repo allows deploying a basic vSphere lab on Nimbus VMware
internal cloud.

The following script uploads and executes a deployment script on the
Nimbus gateway:

    $ ./deploy-base.sh

The following components are deployed:

* 1 ESX
* 1 vCenter
* 1 worker

You need to replace all the FIXME_* in the scripts and config files.
