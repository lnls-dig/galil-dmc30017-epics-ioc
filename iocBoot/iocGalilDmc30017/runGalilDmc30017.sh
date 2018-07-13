#!/bin/sh

set -e
set +u

# Source environment
. ./checkEnv.sh

# Parse command-line options
. ./parseCMDOpts.sh "$@"

# Check last command return status
if [ $? -ne 0 ]; then
        echo "Could not parse command-line options" >&2
        exit 1
fi

if [ -z "$EPICS_CA_MAX_ARRAY_BYTES" ]; then
    EPICS_CA_MAX_ARRAY_BYTES="50000000"
fi

if [ -z "$IPADDR" ]; then
    echo "Device IP address not set. Please use the -i option or set \$IPADDR environment variable" >&2
    exit 3
fi

if [ -z "$IPPORT" ]; then
    IPPORT="5025"
fi

cd "$IOC_BOOT_DIR"

EPICS_CA_MAX_ARRAY_BYTES="$EPICS_CA_MAX_ARRAY_BYTES" IPADDR="$IPADDR" IPPORT="$IPPORT" P="$P" R="$R" \
VELO="$VELO" \
VMAX="$VMAX" \
ACCL="$ACCL" \
BDST="$BDST" \
BVEL="$BVEL" \
BACC="$BACC" \
MRES="$MRES" \
SREV="$SREV" \
ERES="$ERES" \
DHLM="$DHLM" \
DLLM="$DLLM" \
OFF="$OFF" \
UEIP="$UEIP" \
RTRY="$RTRY" \
NTM="$NTM" \
MTRTYPE="$MTRTYPE" \
MTRON="$MTRON" \
EGU="$EGU" \
DEFAULT_HOMETYPE="$DEFAULT_HOMETYPE" \
DEFAULT_LIMITTYPE="$DEFAULT_HOMETYPE" \
AMP_GAIN="$AMP_GAIN" \
DIR="$DIR" \
ENC_TYPE="$ENC_TYPE" \
BISS_POLL="$BISS_POLL" \
BISS_CLKDIV="$BISS_CLKDIV" \
BISS_DATA1="$BISS_DATA1" \
BISS_DATA2="$BISS_DATA2" \
BISS_ZEROPAD="$BISS_ZEROPAD" \
BISS_INPUT="$BISS_INPUT" \
BISS_LEVEL="$BISS_LEVEL" \
"$IOC_BIN" stGalilDmc30017.cmd
