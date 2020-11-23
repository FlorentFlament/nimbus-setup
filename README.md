## Update 2020-11-23

This tool is pretty much broken for now.

I'm in the process of rethinking and rewriting it, so that it be more
flexible and .. working.

That said, some of the scripts in this repo may be useful for some
people. So, letting this here for now.


## Initial README

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
