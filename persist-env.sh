#!/usr/bin/env bash

#--------------------------------------------------------------------------------------------------
# persist-env
# Copyright (c) Hexosse
# Licensed under the MIT license
# http://github.com/bash-suite/persist-env
#--------------------------------------------------------------------------------------------------


# set -e : Exit the script if any statement returns a non-true return value.
# set -u : Exit the script when using uninitialised variable.
# set -o pipefail : Check the exit code of pipeline's last command.
set -euo pipefail

# Reload the file olding the environment variables
env_reload() {
    source /etc/environment
}

# Test if env variable is set
# Eg: if [ -z $(env_is_set "HOSTNAME") ]; then OR if env_is_set "HOSTNAME"; then
env_is_set() {
    if [ $# -lt 1 ]; then
        return 1
    fi

    # Reload environnement variables
    env_reload

    # use printenv to retreive the env
	printenv "${1}" >/dev/null 2>&1

    if [ "$?" -eq 0 ]; then
        return 0
    else
        return 1
    fi
}

# Set an env variable
# Eg: env_set MYVAR "myvalue"
env_set() {
    if [ $# -lt 2 ];then
        return 1
    fi

    # Remove if it exist
	if env_is_set "${1}"; then
        env_unset "${1}"
    fi

    # Add export to /etc/environment
    echo "export ${1}=\"${2}\"" >> /etc/environment

    # Reload environnement variables
    env_reload
}

# Get environnement variable by name or return the default value if defined
# Eg: DEBUG_LEVEL="$( env_get "DEBUG" "0" )"
env_get() {
	local env_name="${1}"

    # Reload environnement variables
    env_reload

	# Did we have a default value specified?
	if [ "${#}" -gt "1" ]; then
		if ! env_is_set "${env_name}"; then
			echo "${2}"
			return 0
		fi
	fi

	# Just output the env value
	printenv "${1}"

    return 0
}

# Unset an env variable
# Eg: env_unset MYVAR
#----------------------------------------------------------------------------------------------------------------------
env_unset() {
    if [ $# -lt 1 ];then
        return 1
    fi

    # Remove export from /etc/environment
    sed -i "/export ${1}=*/d" /etc/environment

    # unset it
    env_is_set "${1}" && unset "${1}"

    # Reload environnement variables
    env_reload

    return 0
}

# Sanity Checks
if ! command -v printenv >/dev/null 2>&1; then
	echo "sed not found, but required."
	exit 127
fi
if ! command -v sed >/dev/null 2>&1; then
	echo "sed not found, but required."
	exit 127
fi
