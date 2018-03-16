###############################################################
# Load DBs provided by Galil Driver with default configurations

## Parameters that can be passed when running the IOC are listed in galil_dmc30017.config.
## Do not use dbLoadTemplate() in order to allow macro substitutions

# -----------------------
#  Motor record features 
# -----------------------
dbLoadRecords("$(GALIL)/GalilSup/Db/galil_motor.template", "P=$(PREFIX), M=$(M), PORT=$(PORT), ADDR=0, EGU=$(EGU), DESC=, VELO=$(VELO),  VMAX=$(VMAX), ACCL=$(ACCL), BDST=$(BDST), BVEL=$(BVEL), BACC=$(BACC), MRES=$(MRES), SREV=$(SREV), ERES=$(ERES), PREC=6, DHLM=$(DHLM), DLLM=$(DLLM), OFF=$(OFF), UEIP=$(UEIP), RTRY=$(RTRY), NTM=$(NTM), PCOF=0, ICOF=0, DCOF=0")

# ----------------------------------------------------
# Additional features to Motor record's functionality
# ----------------------------------------------------
dbLoadRecords("$(GALIL)/GalilSup/Db/galil_motor_extras.template", "P=$(PREFIX), M=$(M), PORT=$(PORT), ADDR=0, PREC=6, SCAN=Passive, MTRTYPE=$(MTRTYPE), MTRON=$(MTRON), EGU=$(EGU)")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_dmc_ctrl.template", "P=$(PREFIX), PORT=$(PORT), SCAN=Passive, DEFAULT_HOMETYPE=$(DEFAULT_HOMETYPE), DEFAULT_LIMITTYPE=$(DEFAULT_LIMITTYPE), PREC=6")

# ----------------
# Digital outputs
# ----------------
# Dig out 1
dbLoadRecords("$(GALIL)/GalilSup/Db/galil_digital_out_bit.template", "P=$(PREFIX), R=$(DIG_OUT0), PORT=$(PORT), WORD=0, MASK=0x000001, ZNAM=Off, ONAM=On, ZSV=NO_ALARM, OSV=NO_ALARM")

# Dig out 2
dbLoadRecords("$(GALIL)/GalilSup/Db/galil_digital_out_bit.template", "P=$(PREFIX), R=$(DIG_OUT1), PORT=$(PORT), WORD=0, MASK=0x000002, ZNAM=Off, ONAM=On, ZSV=NO_ALARM, OSV=NO_ALARM")

# Dig out 3
dbLoadRecords("$(GALIL)/GalilSup/Db/galil_digital_out_bit.template", "P=$(PREFIX), R=$(DIG_OUT2), PORT=$(PORT), WORD=0, MASK=0x000004, ZNAM=Off, ONAM=On, ZSV=NO_ALARM, OSV=NO_ALARM")

# Dig out 4
dbLoadRecords("$(GALIL)/GalilSup/Db/galil_digital_out_bit.template", "P=$(PREFIX), R=$(DIG_OUT3), PORT=$(PORT), WORD=0, MASK=0x000008, ZNAM=Off, ONAM=On, ZSV=NO_ALARM, OSV=NO_ALARM")

# ---------------
# Digital inputs
# ---------------

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_digital_in_bit.template", "P=$(PREFIX), R=$(DIG_IN0), PORT=$(PORT), BYTE=0, MASK=0x000001, ZNAM=Off, ONAM=On, ZSV=NO_ALARM, OSV=NO_ALARM")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_digital_in_bit.template", "P=$(PREFIX), R=$(DIG_IN1), PORT=$(PORT), BYTE=0, MASK=0x000002, ZNAM=Off, ONAM=On, ZSV=NO_ALARM, OSV=NO_ALARM")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_digital_in_bit.template", "P=$(PREFIX), R=$(DIG_IN2), PORT=$(PORT), BYTE=0, MASK=0x000004, ZNAM=Off, ONAM=On, ZSV=NO_ALARM, OSV=NO_ALARM")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_digital_in_bit.template", "P=$(PREFIX), R=$(DIG_IN3), PORT=$(PORT), BYTE=0, MASK=0x000008, ZNAM=Off, ONAM=On, ZSV=NO_ALARM, OSV=NO_ALARM")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_digital_in_bit.template", "P=$(PREFIX), R=$(DIG_IN4), PORT=$(PORT), BYTE=0, MASK=0x000010, ZNAM=Off, ONAM=On, ZSV=NO_ALARM, OSV=NO_ALARM")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_digital_in_bit.template", "P=$(PREFIX), R=$(DIG_IN5), PORT=$(PORT), BYTE=0, MASK=0x000020, ZNAM=Off, ONAM=On, ZSV=NO_ALARM, OSV=NO_ALARM")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_digital_in_bit.template", "P=$(PREFIX), R=$(DIG_IN6), PORT=$(PORT), BYTE=0, MASK=0x000040, ZNAM=Off, ONAM=On, ZSV=NO_ALARM, OSV=NO_ALARM")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_digital_in_bit.template", "P=$(PREFIX), R=$(DIG_IN7), PORT=$(PORT), BYTE=0, MASK=0x000080, ZNAM=Off, ONAM=On, ZSV=NO_ALARM, OSV=NO_ALARM")

# ---------------
# Analog outputs
# ---------------

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_analog_out.template", "P=$(PREFIX), R=$(ANALOG_OUT0), PORT=$(PORT), ADDR=1, PREC=6, LOPR=-10, HOPR=10")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_analog_out.template", "P=$(PREFIX), R=$(ANALOG_OUT1), PORT=$(PORT), ADDR=2, PREC=6, LOPR=-10, HOPR=10")

# --------------
# Analog inputs
# --------------

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_analog_in.template", "P=$(PREFIX), R=$(ANALOG_IN0), PORT=$(PORT), ADDR=1, SCAN=I/O Intr, PREC=6")

dbLoadRecords("$(GALIL)/GalilSup/Db/galil_analog_in.template", "P=$(PREFIX), R=$(ANALOG_IN1), PORT=$(PORT), ADDR=2, SCAN=I/O Intr, PREC=6")
