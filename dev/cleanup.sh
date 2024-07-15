#!/usr/bin/env sh
##################################
# shellcheck shell=sh enable=all #
##################################

[ -z "${SHDEBUG}" ] || set -vx

runquiet() {
    "${@}" >/dev/null 2>&1
}

swd="${0%"${0##*/}"}"

if [ -n "${swd}" ]; then
    runquiet cd "${swd}" || {
        printf "Fatal: unable to change current working directory to %s.\n" "${swd}" >&2

        exit 1
    }
fi

###############################
# shellcheck source=/dev/null #
###############################
. ../src/which.extended.sh

scriptDir="$(pwd -P 2>/dev/null)"

[ -x "${scriptDir}/${0##*/}" ] || {
    printf "Fatal: unable to locate %s folder properly.\n" dev >&2

    exit 1
}

#############################
# shellcheck disable=SC2230 #
#############################
which -s rm || {
    printf "This script requires %s command and/or builtin to clean %s.\n" rm "${scriptDir}" >&2
    printf "Please install %s command and relaunch.\n" rm >&2

    exit 1
}

if test -d bin -o -d tests/shellspec; then
    for folder in bin tests/shellspec; do
        [ -d "${scriptDir}/${folder}" ] && runquiet rm -rf "${scriptDir}/${folder}"
    done

    printf "%s has been cleaned.\n" "${scriptDir}" >&2
else
    printf "Nothing to clean at %s.\n" "${scriptDir}" >&2

    exit 1
fi
