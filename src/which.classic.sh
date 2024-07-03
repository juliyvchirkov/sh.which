##################################
# shellcheck shell=sh enable=all #
##################################

which() (
    if [ $# -gt 0 ]; then
        while [ $# -gt 0 ]; do
            case "${1}" in
            --)
                shift

                break

                ;;
            -a)
                locateall="${locateall-1}"

                shift

                ;;
            -s | -sa | -as)
                locateall=
                besilent=1

                shift

                ;;
            -*)
                printf -- "which: invalid option — %s\n\n" "${1#-}" >&2

                exitstatus=2

                set --

                break

                ;;
            *)
                break

                ;;
            esac
        done
    fi

    if [ $# -gt 0 ]; then
        for command; do
            located=

            IFS=":"

            #############################
            # shellcheck disable=SC2086 #
            #############################
            for path in ${PATH}; do
                if [ -x "${path}/${command}" ]; then
                    located=1

                    [ -n "${besilent:-}" ] || printf -- "%s/%s\n" "${path}" "${command}"

                    [ -n "${locateall:-}" ] || break
                fi
            done

            [ -n "${located}" ] || exitstatus=1
        done

        return "${exitstatus:-0}"
    fi

    printf "%s\n\n" "which: locates command(s) and reports to standard output" >&2
    printf "%s\n" "USAGE" >&2
    printf "    %s\n" "which [-as] command …" >&2
    printf "%s\n" "OPTIONS" >&2
    printf "    %s     %s\n" "-a" "print all matches" >&2
    printf "    %s     %s\n" "-s" "silently return 0 if all commands are located or 1 otherwise" >&2
    printf "%s\n" "EXIT STATUS" >&2
    printf "    %s      %s\n" 0 "all commands are located" >&2
    printf "    %s      %s\n" 1 "failed to locate some command(s)" >&2
    printf "    %s      %s\n" 2 "an invalid option is specified" >&2

    return "${exitstatus:-1}"
)
