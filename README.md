# galil-dmc30017-epics-ioc

### Overall

Repository containing the EPICS IOC support for the DMC 30017 Galil Motion Controller.

### Building

In order to build the IOC, from the top level directory, run:

```sh
$ make clean uninstall install
```
### Running

In order to run the IOC, from the top level directory, run:

```sh
$ cd iocBoot/iocGalilDmc30017 &&
$ ./runGalilDmc30017.sh -i "IPADDR"
```

where `IPADDR` is the IP address of the device to connect to. The options
that you can specify (after `./runGalilDmc30017.sh`) are:

- `-p IPPORT`: device port to connect to (default is 5025)
- `-P PREFIX1`: the value of the EPICS `$(P)` macro used to prefix the PV names
- `-R PREFIX2`: the value of the EPICS `$(R)` macro used to prefix the PV names
- `-s VELO`: the default motor velocity (EGU/s)
- `-x VMAX`: the default maximum motor velocity (EGU/s)
- `-a ACCL`: the default acceleration period (seconds)
- `-d BDST`: the default backlash distance (EGU)
- `-v BVEL`: the default backlash velocity (EGU/s)
- `-c BACC`: the default backlash acceleration period (seconds)
- `-r MRES`: the default motor resolution (EGU)
- `-t SREV`: the motor's number of steps per revolution
- `-e ERES`: the encoder resolution (EGU)
- `-h DHLM`: the software high position limit (EGU)
- `-l DLLM`: the software low position limit (EGU)
- `-o OFF`:  the user offset (EGU)
- `-u UEIP`: option specifying whether driver should use encoder when it is present (no, yes)
- `-y RTRY`: the movement retry count
- `-n NTM`: option specifying whether motor shoukd track new target positions immediately or wait the previous move to finish (no, yes)
- `-m MTRTYPE`: the motor type (, , , , )
- `-k MTRON`: option specifying whether motor should start powered on/off (no, yes)
- `-g EGU`: the engineering units used
- `-w DEFAULT_HOMETYPE`:  the home switch type, normal open (NO) or normal closed (NC)
- `-z DEFAULT_LIMITTYPE`: the limit switch type, normal open (NO) or normal closed (NC)

In some situations it is desired to run the process using procServ,
which enables the IOC to be controlled by the system. In order to
run the IOC with procServ, instead of the previous command, run:

```sh
$ procServ -n "DMC30017" -f -i ^C^D 20000 ./runGalilDmc30017.sh -i "10.0.18.77" -p "5025" -P "TEST:" -R "DMC30017:"
```

where the options are as previously described.
