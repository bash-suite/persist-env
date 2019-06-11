# ![](https://github.com/docker-suite/artwork/raw/master/logo/png/logo_32.png) Persist environment variables
![License: MIT](https://img.shields.io/github/license/docker-suite/goss.svg?color=green&style=flat-square)

persist-env give more flexibility to set or unset system wide environment variable.

persist-env is a set of functions desgined to create, edit or remove any environment variables accessible all throughout the system, by each and every user, both locally and remotely.

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Using persist-env

**source** the *persist-env.sh* script at the beginning of any Bash program.

``` bash
    #!/bin/bash
    source /path/to/persist-env.sh
```

**set** a variables

``` bash
    env_set MYVAR "myvalue"
```

**get** it

``` bash
    env_get MYVAR
    # or
    printenv MYVAR
```

then **unset** it

``` bash
    env_unset MYVAR
```
