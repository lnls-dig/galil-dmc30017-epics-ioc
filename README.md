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
- `-t TELNET_PORT`: telnet port to use for connecting to procServ
- `-R PREFIX2`: the value of the EPICS `$(R)` macro used to prefix the PV names
- `-s VELO`: the default motor velocity (EGU/s)
- `-x VMAX`: the default maximum motor velocity (EGU/s)
- `-a ACCL`: the default acceleration period (seconds)
- `-d BDST`: the default backlash distance (EGU)
- `-v BVEL`: the default backlash velocity (EGU/s)
- `-c BACC`: the default backlash acceleration period (seconds)
- `-r MRES`: the default motor resolution (EGU)
- `-T SREV`: the motor's number of steps per revolution
- `-e ERES`: the encoder resolution (EGU)
- `-h DHLM`: the software high position limit (EGU)
- `-l DLLM`: the software low position limit (EGU)
- `-o OFF`:  the user offset (EGU)
- `-u UEIP`: option specifying whether driver should use encoder when it is present (no, yes)
- `-y RTRY`: the movement retry count
- `-n NTM`: option specifying whether motor shoukd track new target positions immediately or wait the previous move to finish (no, yes)
- `-m MTRTYPE`: the motor type (servo, rev-servo, ha-stepper, la-stepper, rev-ha-stepper, rev-la-stepper, pwm-servo, pwm-rev-servo, ethcat-pos, ethcat-torque, ethcat-rev-torque)
- `-k MTRON`: option specifying whether motor should start powered on/off (no, yes)
- `-g EGU`: the engineering units used
- `-w DEFAULT_HOMETYPE`:  the home switch type, normal open (NO) or normal closed (NC)
- `-z DEFAULT_LIMITTYPE`: the limit switch type, normal open (NO) or normal closed (NC)
- `-G AMP_GAIN`: the default amplifier gain (0, 1, 2, 3). Each option translates to the following max current: option *0* = 0.75 A for steppers and 0.4 for servos; option *1* = 1.5 A for steppers and 0.8 A for servos; option *2* = 3 A for steppers and 1.6 A for servos; option *3* = 6 A for steppers (servo configuration does not accept this option)
- `-D DIR`: the user direction (neg, pos)
- `-E ENC_TYPE`: the encoder type (normal-quad, rev-quad, pulse-and-dir, rev-pulse-and-dir)
- `-O BISS_POOL`: option to enable BiSS polling (no, yes)
- `-C BISS_CLKDIV`: the BiSS clock divider (4 <= clk <= 26)
- `-A BISS_DATA1`: the BiSS data 1 number of bits (-38 <= num <= 38)
- `-B BISS_DATA2`: the BiSS data 2 number of bits (0 <= num <= 38)
- `-Z BISS_ZEROPAD`: the BiSS zero padding (0 <= num <= 7)
- `-I BISS_INPUT`: the controller BiSS input configuration (off, replace-main, replace-aux)
- `-L BISS_LEVEL`: the BiSS level (low-low, low-high, high-low, high-high)

Obs:

   Most DMC30017 configuration options only take effect when there is no
autosave file to use in startup. The motor on/off, motor type, amplifier gain,
user direction, encoder type, and BiSS related options are the only exceptions,
taking precedence over the autosaved values when defined.

   The encoder type can only be set while the amplifier is powered off,
so in order for the startup settings to take effect, the motor amplifier
MUST NOT be powered on at startup.

In some situations it is desired to run the process using procServ,
which enables the IOC to be controlled by the system. In order to
run the IOC with procServ, instead of the previous command, run:

```sh
$ procServ -n "DMC30017" -f -i ^C^D 20000 ./runGalilDmc30017.sh -i "10.0.18.77" -p "5025" -P "TEST:" -R "DMC30017:"
```

where the options are as previously described.
