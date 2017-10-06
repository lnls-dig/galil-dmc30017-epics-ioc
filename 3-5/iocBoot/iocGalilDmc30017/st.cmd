#!../../bin/linux-x86_64/GalilDmc30017

## You may have to change GalilDmc30017 to something else
## everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/GalilDmc30017.dbd"
GalilDmc30017_registerRecordDeviceDriver pdbbase

## Load record instances
#dbLoadRecords("db/xxx.db","user=janitoHost")

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx,"user=janitoHost"
