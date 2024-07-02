#!/usr/bin/env sh
#################################################
# shellcheck shell=sh enable=all disable=SC2230 #
#################################################

[ -z "${SHDEBUG}" ] || set -vx

runquiet() {
    "${@}" >/dev/null 2>&1
}

safecd() {
    runquiet cd -- "${1}" || {
        printf -- "Fatal: unable to change directory to %s\n" "${1}" >&2

        exit 1
    }
}

[ -z "${0%"${0##*/}"}" ] || safecd "${0%"${0##*/}"}"

###############################
# shellcheck source=/dev/null #
###############################
. ../src/which.extended.sh

for command in [ cat chmod cp curl ed envsubst git grep ln mkdir printf pwd rm tar umask uname xz; do
    which -s "${command}" || notlocatedlist="${notlocatedlist}   ${command}\n"
done

if [ -n "${notlocatedlist}" ]; then
    printf "Tests runner requires %s command(s) and/or builtin(s) to operate properly\n" next >&2
    printf "%b\n" "${notlocatedlist}" >&2
    printf "Please install %s command(s) and relaunch.\n" required >&2

    exit 1
fi

scriptDir="$(pwd -P 2>/dev/null)"

umask 022

[ -d bin ] || runquiet mkdir -m755 bin

safecd bin

if [ ! -x shellspec ]; then
    printf "%s command is required to run tests.\n" shellspec >&2
    printf -- "Fetching and installing %s command to %s…\n" shellspec "${scriptDir}/bin" >&2

    if runquiet git clone https://github.com/shellspec/shellspec.git shellspec.command; then
        runquiet ln -s shellspec.command/shellspec shellspec

        runquiet ed shellspec.command/lib/general.sh <<EOF
3i
[ -z "\${YASH_VERSION:-}" ] || { set +o | grep "+o posix" >/dev/null 2>&1 || unset YASH_VERSION; }

.
w
q
EOF

        printf -- "%s command has been installed to %s.\n" shellspec "${scriptDir}/bin" >&2
    else
        safecd ..

        runquiet rm -rf bin

        printf -- "Fatal: unable to fetch and install %s command to %s\n" shellspec "${scriptDir}/bin" >&2

        exit 1
    fi
fi

os="$(uname -s)"

if [ ! -x shellcheck ]; then
    if [ "${os}" = Darwin ] || [ "${os}" = Linux ]; then
        [ "${os}" = Darwin ] && oslo=darwin || oslo=linux

        arch="$(uname -m)"

        if [ "${arch}" = x86_64 ] || [ "${arch}" = aarch64 ]; then
            printf "%s command is required to run tests.\n" shellcheck >&2
            printf -- "Fetching and installing %s command to %s…\n" shellcheck "${scriptDir}/bin" >&2

            shellcheckRemote="https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.${oslo}.${arch}.tar.xz"

            runquiet mkdir -m755 shellcheck.command

            safecd shellcheck.command

            if curl -fsSL "${shellcheckRemote}" | xz -d - | tar --strip-components=1 -xf -; then
                safecd ..

                runquiet ln -s shellcheck.command/shellcheck shellcheck

                printf -- "%s command has been installed to %s.\n" shellcheck "${scriptDir}/bin" >&2
            else
                safecd ..

                runquiet rm -rf shellcheck.command

                printf -- "Unable to fetch and install %s command to %s\n" shellcheck "${scriptDir}/bin" >&2
            fi
        fi
    fi

    if [ ! -x shellcheck ]; then
        if which -is shellcheck; then
            shellcheck="$(which -i shellcheck)"

            runquiet ln -s "${shellcheck}" shellcheck

            printf -- "Utilizing %s command installed locally at %s.\n" shellcheck "${shellcheck}" >&2
        else
            cat <<EOF >shellcheck
#!/usr/bin/env sh
##################################
# shellcheck shell=sh enable=all #
##################################

[ -z "\${SHDEBUG}" ] || set -vx
EOF

            runquiet chmod 755 shellcheck
        fi
    fi
fi

sh=busybox
shell="$(which -i "${sh}")"

if [ -n "${shell}" ]; then
    [ -x "${sh}" ] || {
        cat <<EOF >"${sh}"
#!/usr/bin/env sh
##################################
# shellcheck shell=sh enable=all #
##################################

[ -z "\${SHDEBUG}" ] || set -vx

[ "\${1}" = ash ] || [ "\${1}" = sh ] || set -- sh "\${@}"

exec ${shell} "\${@}"
EOF

        runquiet chmod 755 "${sh}"
    }

    [ -d "sh.${sh}" ] || runquiet mkdir -m755 "sh.${sh}"

    safecd "sh.${sh}"

    [ -x sh ] || runquiet ln -s "${shell}" sh

    safecd ..
fi

shells="ash bash dash gwsh ksh mksh loksh oksh pdksh posh yash zsh"

for sh in ${shells}; do
    shell="$(which -i "${sh}")"

    if [ -n "${shell}" ]; then
        [ "${sh}" = loksh ] || [ "${sh}" = pdksh ] || {
            test "${sh}" = posh -a "${os}" = Darwin || test "${sh}" = oksh -a "${os}" != Darwin || {
                [ -x "${sh}" ] || runquiet ln -s "${shell}" "${sh}"

                [ -d "sh.${sh}" ] || runquiet mkdir -m755 "sh.${sh}"

                [ -x "sh.${sh}/sh" ] || {
                    safecd "sh.${sh}"

                    runquiet ln -s "../${sh}" sh

                    safecd ..
                }
            }
        }
    fi
done

if [ ! -x ash ] && [ -x dash ]; then
    runquiet ln -s dash ash

    runquiet mkdir -m755 sh.ash

    safecd sh.ash

    runquiet ln -s ../ash sh

    safecd ..
fi

#############################
# shellcheck disable=SC2209 #
#############################
command=sh
[ -x "${command}" ] || {
    binary="$(which -i "${command}")"

    runquiet ln -s "${binary}" "${command}"
}

command=zsh
if [ -x "${command}" ]; then
    shell="$(which -i "${command}")"

    safecd "sh.${command}"

    runquiet rm -f sh

    runquiet ln -s "${shell}" sh

    safecd ..

    runquiet rm -f "${command}"

    cat <<EOF >"${command}"
#!/usr/bin/env sh
##################################
# shellcheck shell=sh enable=all #
##################################

[ -z "\${SHDEBUG}" ] || set -vx

exec ${shell} --emulate ksh "\${@}"
EOF

    runquiet chmod 755 "${command}"
fi

command=which
[ -x "${command}" ] || {
    cat <<EOF >"${command}"
#!/usr/bin/env sh
##################################
# shellcheck shell=sh enable=all #
##################################

[ -z "\${SHDEBUG}" ] || set -vx

[ -z "\${0%"\${0##*/}"}" ] || {
    cd "\${0%"\${0##*/}"}" || exit
}

###############################
# shellcheck source=/dev/null #
###############################
. ../../src/which.extended.sh

#############################
# shellcheck disable=SC2230 #
#############################
which "\${@}"
EOF

    runquiet chmod 755 "${command}"
}

#############################
# shellcheck disable=SC2209 #
#############################
command=printf
[ -x "${command}" ] || {
    binary="$(which -i "${command}")"

    [ -z "${binary}" ] || runquiet ln -s "${binary}" "${command}"

    [ -x "${command}" ] || {
        cat <<EOF >"${command}"
#!/usr/bin/env sh
##################################
# shellcheck shell=sh enable=all #
##################################

[ -z "\${SHDEBUG}" ] || set -vx

#############################
# shellcheck disable=SC2059 #
#############################
printf -- "\${@}"
EOF

        runquiet chmod 755 "${command}"
    }
}

command=[
[ -x "${command}" ] || {
    binary="$(which -i "${command}")"

    [ -n "${binary}" ] || binary="$(which -i test)"

    [ -z "${binary}" ] || runquiet ln -s "${binary}" "${command}"

    [ -x "${command}" ] || {
        cat <<EOF >"${command}"
#!/usr/bin/env sh
##################################
# shellcheck shell=sh enable=all #
##################################

[ -z "\${SHDEBUG}" ] || set -vx

for arg; do
    test "\${arg}" = ] || args="\${args} \${arg}"
done

#############################
# shellcheck disable=SC2086 #
#############################
test \${args}
EOF

        runquiet chmod 755 "${command}"
    }
}

safecd ..

printf "Preparing %s tests…\n" shellspec >&2

[ -d tests/shellspec ] || runquiet mkdir -m755 tests/shellspec

[ -r tests/shellspec/001-shellcheck.sh ] || runquiet cp tests/templates/shellcheck.sh tests/shellspec/001-shellcheck.sh

testsbin="${scriptDir}/bin"

export testsbin shellbintitle shellbin shebang extrapath shellbinary shellfulltitle

substenv() {
    #############################
    # shellcheck disable=SC2016 #
    #############################
    envsubst '$testsbin $shellbintitle $shellbin $shebang $extrapath $shellbinary $shellfulltitle' <"tests/templates/which.${1}.sh"
}

shellbintitle=busybox
shellbin="bin/sh.${shellbintitle}/sh"
shebang="${scriptDir}/${shellbin}"
extrapath="${shebang%/*}"
shellbinary="${shebang##*/}"
shellfulltitle="${shellbintitle} ${shellbinary}"

[ -r "tests/shellspec/002-which-classic-${shellbintitle}-sh.sh" ] ||
    substenv classic >"tests/shellspec/002-which-classic-${shellbintitle}-sh.sh"

[ -r "tests/shellspec/003-which-extended-${shellbintitle}-sh.sh" ] ||
    substenv extended >"tests/shellspec/003-which-extended-${shellbintitle}-sh.sh"

testid=4

for sh in ${shells}; do
    shellbintitle="${sh}"

    shellbin="bin/${shellbintitle}"
    shebang="${scriptDir}/${shellbin}"
    extrapath="${shebang%/*}"
    shellbinary="${shebang##*/}"
    shellfulltitle="${shellbinary}"

    testScript="tests/shellspec/$(printf "%03d" "${testid}")-which-classic-${shellbintitle}-regular.sh"

    [ -r "${testScript}" ] || substenv classic >"${testScript}"

    testid="$((testid + 1))"

    testScript="tests/shellspec/$(printf "%03d" "${testid}")-which-extended-${shellbintitle}-regular.sh"

    [ -r "${testScript}" ] || substenv extended >"${testScript}"

    testid="$((testid + 1))"

    shellbin="bin/sh.${shellbintitle}/sh"
    shebang="${scriptDir}/${shellbin}"
    extrapath="${shebang%/*}"
    shellbinary="${shebang##*/}"
    shellfulltitle="${shellbintitle} ➤ POSIX ${shellbinary}"

    testScript="tests/shellspec/$(printf "%03d" "${testid}")-which-classic-${shellbintitle}-sh.sh"

    [ -r "${testScript}" ] || substenv classic >"${testScript}"

    testid="$((testid + 1))"

    testScript="tests/shellspec/$(printf "%03d" "${testid}")-which-extended-${shellbintitle}-sh.sh"

    [ -r "${testScript}" ] || substenv extended >"${testScript}"

    testid="$((testid + 1))"
done

shell=bin/sh

bin/shellspec --shell "${shell}" tests/shellspec/001-shellcheck.sh

[ -x bin/sh.busybox/sh ] && shell=bin/sh.busybox/sh

bin/shellspec --shell "${shell}" tests/shellspec/002-which-classic-busybox-sh.sh
bin/shellspec --shell "${shell}" tests/shellspec/003-which-extended-busybox-sh.sh

testid=4

shellspec() {
    bin/shellspec --shell "${shell}" "tests/shellspec/$(printf "%03d" "${testid}")-which-${1}-${sh}-${2}.sh"
}

for sh in ${shells}; do
    shell=bin/sh

    [ -x "bin/${sh}" ] && shell="bin/${sh}"

    shellspec classic regular

    testid="$((testid + 1))"

    shellspec extended regular

    testid="$((testid + 1))"

    shell=bin/sh

    [ -x "bin/sh.${sh}/sh" ] && shell="bin/sh.${sh}/sh"

    shellspec classic sh

    testid="$((testid + 1))"

    shellspec extended sh

    testid="$((testid + 1))"
done
