#!/bin/sh

set -e
set +u

# Parse command-line options
. ./parseCMDOpts.sh "$@"

# Use defaults if not set
if [ -z "${DEVICE_TELNET_PORT}" ]; then
   DEVICE_TELNET_PORT="20000"
fi

if [ -z "${DMC30017_INSTANCE}" ]; then
   DMC30017_INSTANCE="1"
fi

set -u

# Run run*.sh scripts with procServ
/usr/local/bin/procServ -f -n DMC30017_${DMC30017_INSTANCE} -i ^C^D ${DEVICE_TELNET_PORT} ./runGalilDmc30017.sh "$@"
