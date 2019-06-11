#!/usr/bin/env bash

#--------------------------------------------------------------------------------------------------
# persist-env
# Copyright (c) Hexosse
# Licensed under the MIT license
# http://github.com/bash-suite/persist-env
#--------------------------------------------------------------------------------------------------

# Including persist-env functions
source persist-env.sh

echo
env_set MYVAR "myvalue"
echo -n "env_get MYVAR: " && env_get MYVAR
echo -n "printenv MYVAR: " && printenv MYVAR
env_unset MYVAR

echo
echo -n "default value to MYVAR2: " && env_get MYVAR2 "myvalue2"

echo
env_set MYVAR3 $(env_get MYVAR3 "myvalue3")
echo -n "set default value to MYVAR3: " && env_get MYVAR3
env_unset MYVAR3

echo
myvar4() {
    env_set MYVAR4 "myvalue4"
    echo -n "env_get MYVAR4 from function: " && env_get MYVAR4
    echo -n "printenv MYVAR4 from function: " && printenv MYVAR4
    echo -n "echo \$MYVAR4 from function: " && echo ${MYVAR4}
}
myvar4
echo -n "env_get MYVAR4 outside function: " && env_get MYVAR4
echo -n "printenv MYVAR4 outside function: " && printenv MYVAR4
echo -n "echo \$MYVAR4 outside function: " && echo ${MYVAR4}

env_unset MYVAR4
echo -n "env_unset MYVAR4: " && env_get MYVAR4 "MYVAR4 is unset"

echo
env_set MYVAR5 "myvalue5"
if env_is_set "MYVAR5"; then
    echo -n "MYVAR5 is defined: " && env_get MYVAR5
fi

echo
