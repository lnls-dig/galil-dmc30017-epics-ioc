# galil-dmc30017-epics-ioc

## Overall

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

- `-p IPPORT`: device port to connect to (optional)
- `-P PREFIX1`: the value of the EPICS `$(P)` macro used to prefix the PV names (optional)
- `-R PREFIX2`: the value of the EPICS `$(R)` macro used to prefix the PV names (optional)

In some situations it is desired to run the process using procServ,
which enables the IOC to be controlled by the system. In order to
run the IOC with procServ, instead of the previous command, run:

```sh
$ procServ -n "DMC30017" -f -i ^C^D 20000 ./runGalilDmc30017.sh -i "10.0.18.77" -p "5025" -P "TEST:" -R "DMC30017:"
```

where the options are as previously described.
