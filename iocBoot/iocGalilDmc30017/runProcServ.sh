#!/bin/sh

set -e
set +u

# Parse command-line options
. ./parseCMDOpts.sh "$@"

# Use defaults if not set
UNIX_SOCKET=""
if [ -z "${DEVICE_TELNET_PORT}" ]; then
    UNIX_SOCKET="true"
fi

if [ -z "${DMC30017_INSTANCE}" ]; then
   DMC30017_INSTANCE="1"
fi

set -u

# Run run*.sh scripts with procServ
if [ "${UNIX_SOCKET}" ]; then
    /usr/local/bin/procServ -f -n DMC30017_${DMC30017_INSTANCE} -i ^C^D unix:./procserv.sock ./runGalilDmc30017.sh "$@"
else
    /usr/local/bin/procServ -f -n DMC30017_${DMC30017_INSTANCE} -i ^C^D ${DEVICE_TELNET_PORT} ./runGalilDmc30017.sh "$@"
fi
