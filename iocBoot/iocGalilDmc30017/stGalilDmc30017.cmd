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

## Load records provided by Galil Driver Support

< galil_load_dbs.cmd

## Load Sirius-standard high level records and aliases
dbLoadRecords("$(TOP)/db/GalilHighLevel.db", "P=$(PREFIX), M=$(M), EGU=$(EGU), DIG_OUT0=$(DIG_OUT0), DIG_OUT1=$(DIG_OUT1), DIG_OUT2=$(DIG_OUT2), DIG_OUT3=$(DIG_OUT3), DIG_IN0=$(DIG_IN0), DIG_IN1=$(DIG_IN1), DIG_IN2=$(DIG_IN2), DIG_IN3=$(DIG_IN3), DIG_IN4=$(DIG_IN4), DIG_IN5=$(DIG_IN5), DIG_IN6=$(DIG_IN6), DIG_IN7=$(DIG_IN7), ANALOG_OUT0=$(ANALOG_OUT0), ANALOG_OUT1=$(ANALOG_OUT1), ANALOG_IN0=$(ANALOG_IN0), ANALOG_IN1=$(ANALOG_IN1)")

## Galil Driver required functions

GalilCreateController("$(PORT)", "${IPADDR}", 8)
GalilCreateAxis("$(PORT)","A",1,"",1)
GalilStartController("$(PORT)", "", 1, 0)

< save_restore.cmd

iocInit

# Set controller gain to comply with motor rated current
dbpf "DMC01:A_AMPGAIN_CMD" "1"

# save things every 5 seconds
create_monitor_set("auto_settings_galil_dmc30017.req", 5,"P=$(PREFIX), M=$(M), DIG_OUT0=$(DIG_OUT0), DIG_OUT1=$(DIG_OUT1), DIG_OUT2=$(DIG_OUT2), DIG_OUT3=$(DIG_OUT3), DIG_IN0=$(DIG_IN0), DIG_IN1=$(DIG_IN1), DIG_IN2=$(DIG_IN2), DIG_IN3=$(DIG_IN3), DIG_IN4=$(DIG_IN4), DIG_IN5=$(DIG_IN5), DIG_IN6=$(DIG_IN6), DIG_IN7=$(DIG_IN7), ANALOG_OUT0=$(ANALOG_OUT0), ANALOG_OUT1=$(ANALOG_OUT1), ANALOG_IN0=$(ANALOG_IN0), ANALOG_IN1=$(ANALOG_IN1)")
# The following line is necessary because of the save file name used in save_restore.cmd
set_savefile_name("auto_settings_galil_dmc30017.req", "auto_settings_$(PREFIX).sav")
