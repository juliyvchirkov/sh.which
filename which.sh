##################################
# shellcheck shell=sh enable=all #
##################################

which() (
    [ "${1}" = "--" ] && shift

    if [ $# -gt 0 ]; then
                      #############################
                      # shellcheck disable=SC2086 #
                      #############################
        for path in $(IFS=: && printf "%s " ${PATH}); do
            [ -x "${path}/${1}" ] && printf "%s/%s" "${path}" "${1}" && return 0
        done

        return 1
    fi

    printf >&2 "%s: %s [--] %s\n%s\n" "Usage" "which" "COMMAND" "Writes the full path of COMMAND to standard output."

    return 1
)
