#!/bin/sh

# Use defaults if not set
if [ -z "${DMC30017_DEVICE_TELNET_PORT}" ]; then
   DMC30017_DEVICE_TELNET_PORT=20000
fi

# Run run*.sh scripts with procServ
/usr/local/bin/procServ -f -n galil_dmc30017_${DMC30017_INSTANCE} -i ^C^D ${DMC30017_DEVICE_TELNET_PORT} ./runGalilDmc30017.sh "$@"
