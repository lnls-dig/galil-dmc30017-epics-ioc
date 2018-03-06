#!../../bin/linux-x86_64/GalilDmc30017

< envPaths
< galil_dmc30017.config

# Log solicited command/response traffic into galil_debug.txt
epicsEnvSet("GALIL_DEBUG_FILE", "galil_debug.txt")

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/GalilDmc30017.dbd"
GalilDmc30017_registerRecordDeviceDriver pdbbase

cd "${TOP}/iocBoot/${IOC}"

epicsEnvSet("IOC_APP_DIR", "${TOP}/galilDmc30017App")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_motor.template", "P=$(P)$(R), M=A, PORT=Galil, ADDR=0, EGU=mm, DESC=, VELO=0.25,  VMAX=0.25, ACCL=2, BDST=0, BVEL=0, BACC=5, MRES=.000001975, SREV=1000, ERES=0.000625, PREC=5, DHLM=86.9, DLLM=0, OFF=0, UEIP=No, RTRY=0, NTM=YES, PCOF=0, ICOF=0, DCOF=0")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_motor_extras.template", "P=$(P)$(R), M=A, PORT=Galil, ADDR=0, PREC=3, SCAN=Passive, MTRTYPE=2, MTRON=0, EGU=mm")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_dmc_ctrl.template", "P=$(P)$(R), PORT=Galil, SCAN=Passive, DEFAULT_HOMETYPE=1, DEFAULT_LIMITTYPE=1, PREC=5")

#dbLoadTemplate("${IOC_APP_DIR}/Db/galil_motors.substitutions")
#dbLoadTemplate("${IOC_APP_DIR}/Db/galil_motor_extras.substitutions")
#dbLoadTemplate("${IOC_APP_DIR}/Db/galil_dmc_ctrl.substitutions")

GalilCreateController("Galil", "${IPADDR}", 8)
GalilCreateAxis("Galil","A",1,"",1)
GalilStartController("Galil", "", 1, 0)

< save_restore.cmd

iocInit

# Set controller gain to comply with motor rated current
dbpf "DMC01:A_AMPGAIN_CMD" "1"

# save things every 5 seconds
create_monitor_set("auto_settings_galil_dmc30017.req", 5,"P=$(P)$(R)")
# The following line is necessary because of the save file name used in save_restore.cmd
set_savefile_name("auto_settings_galil_dmc30017.req", "auto_settings_${P}${R}.sav")
