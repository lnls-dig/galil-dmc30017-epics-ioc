#!../../bin/linux-x86_64/GalilDmc30017

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/GalilDmc30017.dbd"
GalilDmc30017_registerRecordDeviceDriver pdbbase

cd "${TOP}/iocBoot/${IOC}"

epicsEnvSet("IOC_APP_DIR", "${TOP}/GalilDmc30017App")

iocInit
