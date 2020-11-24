Nimbus deployment tool
----------------------

Deneric tool to deploy a nimbus testbed that relies on as few as
possible environment variables.

### Rationale

But we already have such tool, and it's called `nimbus`... The
rationale behind writing a wrapping tool is that `nimbus` is a very
generic tool and has many options. Finding all the relevant options,
and writing the configuration file, for my use case is actually pretty
heavy. Documenting this process is similar to writing a code that does
that. So why not writing something clean that others could refer to
and use.

### Expected outcome

A file in `~/bin` that I can execute. It would take a configuration
file (either one specified on the command line or a default one), and
then deploy a lab consisting of:

* 1 ESX
* 1 vCenter
* 1 worker (to allocate static IPs)

### Input

Input will be provided as environment variables, with a `NP_` prefix
standing for "Nimbus Platform".

* `NP_NAME`: A platform name that will be used to identify the
  platform instance deployed by the tool (so that one can deploy
  several labs). The name is mandatory.

* `NP_ESX_BUILD`, `NP_VCENTER_BUILD`: build numbers identifying the
  version of the ESX and vCenter to be deployed. Sane defaults should
  be provided.

* `NP_CPU`, `NP_RAM`, `NP_DISK`: Amount of resources to allocate for
  the ESX (in GB for RAM and DISK). Minimalist defaults should be
  provided.
