#!../../bin/linux-x86_64/GalilDmc30017

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/GalilDmc30017.dbd"
GalilDmc30017_registerRecordDeviceDriver pdbbase

cd "${TOP}/iocBoot/${IOC}"

epicsEnvSet("IOC_APP_DIR", "${TOP}/GalilDmc30017App")

dbLoadTemplate("${IOC_APP_DIR}/Db/galil_motors.substitutions")
dbLoadTemplate("${IOC_APP_DIR}/Db/galil_motor_extras.substitutions")
dbLoadTemplate("${IOC_APP_DIR}/Db/galil_dmc_ctrl.substitutions")

GalilCreateController("Galil", "${IPADDR}", 8)
GalilCreateAxis("Galil","A",1,"",1)
GalilStartController("Galil", "", 1, 0)

iocInit
