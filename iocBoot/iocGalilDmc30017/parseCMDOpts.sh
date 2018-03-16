#!/bin/sh

while [ "$#" -gt 0 ]; do
    case "$1" in
        "-P") P="$2" ;;
        "-R") R="$2" ;;
        "-i"|"--ip-addr") IPADDR="$2" ;;
        "-p"|"--ip-port") IPPORT="$2" ;;
        "-s"|"--speed") VELO="$2" ;;
        "-x"|"--max-speed") VMAX="$2" ;;
        "-a"|"--acceleration") ACCL="$2" ;;
        "-d"|"--backlash-distance") BDST="$2" ;;
        "-v"|"--backlash-velocity") BVEL="$2" ;;
        "-c"|"--backlash-acceleration") BACC="$2" ;;
        "-r"|"--motor-resolution") MRES="$2" ;;
        "-t"|"--steps-per-revolution") SREV="$2" ;;
        "-e"|"--encoder-resolution") ERES="$2" ;;
        "-h"|"--high-soft-limit") DHLM="$2" ;;
        "-l"|"--low-soft-limit") DLLM="$2" ;;
        "-o"|"--user-offset") OFF="$2" ;;
        "-u"|"--use-encoder")        if [ "$(echo "$2" | tr "[:upper:]" "[:lower:]")" = "yes" ]; then
                                       UEIP="Yes"
                                     else
                                       UEIP="No"
                                     fi
                                     ;;
        "-y"|"--retry") RTRY="$2" ;;
        "-n"|"--new-target-monitor") if [ "$(echo "$2" | tr "[:upper:]" "[:lower:]")" = "yes" ]; then
                                       NTM="YES"
                                     else
                                       NTM="NO"
                                     fi
                                     ;;
        "-m"|"--motor-type") case "$(echo "$2" | tr "[:upper:]" "[:lower:]")" in
                                 "servo") MTRTYPE="0" ;; # Servo
                                 "rev-servo") MTRTYPE="1" ;; # Rev Servo
	                         "ha-stepper") MTRTYPE="2" ;; # HA Stepper
	                         "la-stepper") MTRTYPE="3" ;; # LA Stepper
	                         "rev-ha-stepper") MTRTYPE="4" ;; # Rev HA Stepper
	                         "rev-la-stepper") MTRTYPE="5" ;; # Rev LA Stepper
	                         "pwm-servo") MTRTYPE="6" ;; # PWM servo
	                         "pwm-rev-servo") MTRTYPE="7" ;; # PWM rev servo
	                         "ethcat-pos") MTRTYPE="8" ;; # EtherCat Position
	                         "ethcat-torque") MTRTYPE="9" ;; # EtherCat Torque
	                         "ethcat-rev-torque") MTRTYPE="10" ;; # EtherCat Rev Torque
                            esac
                            ;;
        "-k"|"--motor-on") if [ "$(echo "$2" | tr "[:upper:]" "[:lower:]")" = "yes" ]; then
                                      MTRON="1" # On
                                     else
                                      MTRON="0" # Off
                                     fi
                                     ;;
        "-g"|"--egu") EGU="$2" ;;
        "-w"|"--home-switch-type") if [ "$(echo "$2" | tr "[:upper:]" "[:lower:]")" = "no" ]; then
                                       DEFAULT_HOMETYPE="0" # normal open
                                   else
                                       DEFAULT_HOMETYPE="1" # normal closed
                                   fi
                                   ;;
        "-z"|"--limit-switch-type") if [ "$(echo "$2" | tr "[:upper:]" "[:lower:]")" = "no" ]; then
                                       DEFAULT_LIMITTYPE="0" # normal open
                                   else
                                       DEFAULT_LIMITTYPE="1" # normal closed
                                   fi
                                   ;;
        *) echo "Usage:" >&2
            echo "  $0 -i IPADDR -p IPPORT [-P P_VAL] [-R R_VAL]" >&2
            echo >&2
            echo " Options:" >&2
            echo "  -i or --ip-addr                Configure IP address to connect to device (required)" >&2
            echo "  -p or --ip-port                Configure IP port number to connect to device" >&2
            echo "  -P                             Configure value of \$(P) macro" >&2
            echo "  -R                             Configure value of \$(R) macro" >&2
            echo "  -s or --speed                  Configure motor speed (EGU/s)" >&2
            echo "  -x or --max-speed              Configure motor max speed (EGU/s)" >&2
            echo "  -a or --acceleration           Configure motor acceleration period (s)" >&2
            echo "  -d or --backlash-distance      Configure backlash distance (EGU)" >&2
            echo "  -v or --backlash-velocity      Configure backlash velocity (EGU/s)" >&2
            echo "  -c or --backlash-acceleration  Configure backlash acceleration period (s)" >&2
            echo "  -r or --motor-resolution       Configure motor resolution (EGU/step)" >&2
            echo "  -t or --steps-per-revolution   Configure motor steps per revolution" >&2
            echo "  -e or --encoder-resolution     Configure encoder resolution (EGU/step)" >&2
            echo "  -h or --high-soft-limit        Configure high software limit (EGU)" >&2
            echo "  -l or --low-soft-limit         Configure low software limit (EGU)" >&2
            echo "  -o or --user-offset            Configure user offset (EGU)" >&2
            echo "  -u or --use-encoder            Enable encoder use if present (yes/no)" >&2
            echo "  -y or --retry                  Configure motor number of retries" >&2
            echo "  -n or --new-target-monitor     Configure new target monitor (yes/no)" >&2
            echo "  -m or --motor-type             Configure motor type (servo, rev-servo, ha-stepper, la-stepper, rev-ha-stepper, rev-la-stepper, pwm-servo, pwm-rev-servo, ethcat-pos, ethcat-torque, ethcat-rev-torque)" >&2
            echo "  -k or --motor-on               Power motor on (yes/no)" >&2
            echo "  -g or --egu                    Configure engineering units" >&2
            echo "  -w or --home-switch-type       Configure home switch type (NO/NC)" >&2
            echo "  -z or --limit-switch-type      Configure limit switch type (NO/NC)" >&2
            exit 2
    esac

    shift 2
done

if [ -z "$IPPORT" ]; then
    IPPORT=5025
fi
