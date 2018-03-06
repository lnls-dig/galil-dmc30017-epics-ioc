#!/bin/sh

# Use defaults if not set
if [ -z "${GALIL_DEVICE_TELNET_PORT}" ]; then
   GALIL_DEVICE_TELNET_PORT=20000
fi

# Run run*.sh scripts with procServ
/usr/local/bin/procServ -f -n galil_dmc30017_${GALIL_INSTANCE} -i ^C^D ${GALIL_DEVICE_TELNET_PORT} ./runGalilDmc30017.sh "$@"
