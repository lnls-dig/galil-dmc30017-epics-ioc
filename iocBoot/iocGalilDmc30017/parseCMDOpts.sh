#!/bin/sh

while [ "$#" -gt 0 ]; do
    case "$1" in
        "-P") P="$2" ;;
        "-R") R="$2" ;;
        "-i"|"--ip-addr") IPADDR="$2" ;;
        "-p"|"--ip-port") IPPORT="$2" ;;
        *) echo "Usage:" >&2
            echo "  $0 -i IPADDR -p IPPORT [-P P_VAL] [-R R_VAL]" >&2
            echo >&2
            echo " Options:" >&2
            echo "  -i or --ip-addr    Configure IP address to connect to device" >&2
            echo "  -p or --ip-port    Configure IP port number to connect to device" >&2
            echo "  -P                 Configure value of \$(P) macro" >&2
            echo "  -R                 Configure value of \$(R) macro" >&2
            exit 2
    esac

    shift 2
done

if [ -z "$IPPORT" ]; then
    IPPORT=5025
fi
