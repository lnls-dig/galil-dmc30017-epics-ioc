TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = GalilDmc30017
# GalilDmc30017.dbd will be created and installed
DBD += GalilDmc30017.dbd

# GalilDmc30017.dbd will be made up from these files:
GalilDmc30017_DBD += base.dbd
GalilDmc30017_DBD += GalilSupport.dbd

# Include dbd files from all support applications:
#GalilDmc30017_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#GalilDmc30017_LIBS += xxx

# GalilDmc30017_registerRecordDeviceDriver.cpp derives from GalilDmc30017.dbd
GalilDmc30017_SRCS += GalilDmc30017_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
GalilDmc30017_SRCS_DEFAULT += GalilDmc30017Main.cpp
GalilDmc30017_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#GalilDmc30017_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
GalilDmc30017_LIBS += GalilSupport
GalilDmc30017_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

