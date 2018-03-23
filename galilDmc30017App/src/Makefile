TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC support library

LIBRARY_IOC += GalilDmc30017Support

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
GalilDmc30017Support_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application

PROD_IOC = GalilDmc30017
# GalilDmc30017.dbd will be created and installed
DBD += GalilDmc30017.dbd

# GalilDmc30017.dbd will be made up from these files:
GalilDmc30017_DBD += base.dbd
GalilDmc30017_DBD += asyn.dbd
GalilDmc30017_DBD += calcSupport.dbd
GalilDmc30017_DBD += asSupport.dbd
GalilDmc30017_DBD += motorSupport.dbd
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

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncGalilDmc30017 into GalilDmc30017Support
    sncGalilDmc30017_SNCFLAGS += +r
    GalilDmc30017_DBD += sncGalilDmc30017.dbd
    GalilDmc30017Support_SRCS += sncGalilDmc30017.stt
    GalilDmc30017Support_LIBS += seq pv
    GalilDmc30017_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncGalilDmc30017Program
    sncGalilDmc30017Program_SNCFLAGS += +m
    sncGalilDmc30017Program_SRCS += sncGalilDmc30017Program.st
    sncGalilDmc30017Program_LIBS += seq pv
    sncGalilDmc30017Program_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link in the code from the support library
GalilDmc30017_LIBS += GalilDmc30017Support

# Finally link to the EPICS Base libraries
GalilDmc30017_LIBS += asyn
GalilDmc30017_LIBS += calc
GalilDmc30017_LIBS += autosave
GalilDmc30017_LIBS += motor
GalilDmc30017_LIBS += GalilSupport
GalilDmc30017_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

