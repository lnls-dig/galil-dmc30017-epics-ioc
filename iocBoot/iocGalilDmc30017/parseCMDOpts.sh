#!/bin/sh

set -e 

usage () {
    echo "Usage:" >&2
    echo "  $1 -t PROCSERV_TELNET_PORT [-P P_VAL] [-R R_VAL] -i IPADDR -p IPPORT " >&2
    echo >&2
    echo " Options:" >&2
    echo "  -t                  Configure procServ telnet port" >&2
    echo "  -P                  Configure value of \$(P) macro" >&2
    echo "  -R                  Configure value of \$(R) macro" >&2
    echo "  -i                  Configure IP address to connect to device (required)" >&2
    echo "  -p                  Configure IP port number to connect to device" >&2
    echo "  -s                  Configure motor speed (EGU/s)" >&2
    echo "  -x                  Configure motor max speed (EGU/s)" >&2
    echo "  -a                  Configure motor acceleration period (s)" >&2
    echo "  -d                  Configure backlash distance (EGU)" >&2
    echo "  -v                  Configure backlash velocity (EGU/s)" >&2
    echo "  -c                  Configure backlash acceleration period (s)" >&2
    echo "  -r                  Configure motor resolution (EGU/step)" >&2
    echo "  -T                  Configure motor steps per revolution" >&2
    echo "  -e                  Configure encoder resolution (EGU/step)" >&2
    echo "  -h                  Configure high software limit (EGU)" >&2
    echo "  -l                  Configure low software limit (EGU)" >&2
    echo "  -o                  Configure user offset (EGU)" >&2
    echo "  -u                  Enable encoder use if present (yes/no)" >&2
    echo "  -y                  Configure motor number of retries" >&2
    echo "  -n                  Configure new target monitor (yes/no)" >&2
    echo "  -m                  Configure motor type (servo, rev-servo, ha-stepper, la-stepper, rev-ha-stepper, rev-la-stepper, pwm-servo, pwm-rev-servo, ethcat-pos, ethcat-torque, ethcat-rev-torque)" >&2
    echo "  -k                  Power motor on (yes/no)" >&2
    echo "  -g                  Configure engineering units" >&2
    echo "  -w                  Configure home switch type (NO/NC)" >&2
    echo "  -z                  Configure limit switch type (NO/NC)" >&2
    echo "  -G                  Configure amplifier gain (0, 1, 2, 3). See dmc30017 manual for the current corresponding to each option." >&2
    echo "  -D                  Configure user direction (pos/neg)" >&2
    echo "  -E                  Configure main encoder type (normal-quad, pulse-and-dir, rev-quad, rev-pulse-and-dir)." >&2
}

while getopts ":t:P:R:i:p:s:x:a:d:v:c:r:T:e:h:l:o:u:y:n:m:k:g:w:z:G:D:E" opt; do
    case "$opt" in
        t) DEVICE_TELNET_PORT="$OPTARG" ;;
        P) P="$OPTARG" ;;
        R) R="$OPTARG" ;;
        i) IPADDR="$OPTARG" ;;
        p) IPPORT="$OPTARG" ;;
        s) VELO="$OPTARG" ;;
        x) VMAX="$OPTARG" ;;
        a) ACCL="$OPTARG" ;;
        d) BDST="$OPTARG" ;;
        v) BVEL="$OPTARG" ;;
        c) BACC="$OPTARG" ;;
        r) MRES="$OPTARG" ;;
        T) SREV="$OPTARG" ;;
        e) ERES="$OPTARG" ;;
        h) DHLM="$OPTARG" ;;
        l) DLLM="$OPTARG" ;;
        o) OFF="$OPTARG" ;;
        u)        if [ "$(echo "$OPTARG" | tr "[:upper:]" "[:lower:]")" = "yes" ]; then
                                       UEIP="Yes"
                                     else
                                       UEIP="No"
                                     fi
                                     ;;
        y) RTRY="$OPTARG" ;;
        n) if [ "$(echo "$OPTARG" | tr "[:upper:]" "[:lower:]")" = "yes" ]; then
                                       NTM="YES"
                                     else
                                       NTM="NO"
                                     fi
                                     ;;
        m) case "$(echo "$OPTARG" | tr "[:upper:]" "[:lower:]")" in
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
                                 *) MTRTYPE="" ;; # Motor type is undefined
                            esac
                            ;;
        k) if [ "$(echo "$OPTARG" | tr "[:upper:]" "[:lower:]")" = "yes" ]; then
                                      MTRON="1" # On
                                     else
                                      MTRON="0" # Off
                                     fi
                                     ;;
        g) EGU="$OPTARG" ;;
        w) if [ "$(echo "$OPTARG" | tr "[:upper:]" "[:lower:]")" = "no" ]; then
                                       DEFAULT_HOMETYPE="0" # normal open
                                   else
                                       DEFAULT_HOMETYPE="1" # normal closed
                                   fi
                                   ;;
        z) if [ "$(echo "$OPTARG" | tr "[:upper:]" "[:lower:]")" = "no" ]; then
                                       DEFAULT_LIMITTYPE="0" # normal open
                                   else
                                       DEFAULT_LIMITTYPE="1" # normal closed
                                   fi
                                   ;;
        G) case "$(echo "$OPTARG" | tr "[:upper:]" "[:lower:]")" in
                                 "0") AMP_GAIN="0" ;; # 0.75 A for stepper, 0.4 A for servo
                                 "1") AMP_GAIN="1" ;; # 1.5 A for stepper, 0.8 A for servo
	                         "2") AMP_GAIN="2" ;; # 3 A for stepper, 1.6 A for servo
	                         "3") AMP_GAIN="3" ;; # 6 A for stepper, N/A
	                         "zero") AMP_GAIN="0" ;; # 0.75 A for stepper, 0.4 A for servo
	                         "one") AMP_GAIN="1" ;; # 1.5 A for stepper, 0.8 A for servo
	                         "two") AMP_GAIN="2" ;; # 3 A for stepper, 1.6 A for servo
	                         "three") AMP_GAIN="3" ;; # 6 A for stepper, N/A
	                         *) AMP_GAIN="" ;; # Amplifier gain is undefined
                            esac
                            ;;
        D) case "$(echo "$OPTARG" | tr "[:upper:]" "[:lower:]")" in
	                         "pos") DIR="0" ;; # User direction is "Positive"
	                         "neg") DIR="1" ;; # User direction is "Negative"
	                         "positive") DIR="0" ;; # User direction is "Positive"
	                         "negative") DIR="1" ;; # User direction is "Negative"
                                 "0") DIR="0" ;; # User direction is "Positive"
                                 "1") DIR="1" ;; # User direction is "Negative"
	                         "zero") DIR="0" ;; # User direction is "Positive"
	                         "one") DIR="1" ;; # User direction is "Negative"
	                         *) DIR="" ;; # User direction is undefined
                            esac
                            ;;
        E) case "$(echo "$OPTARG" | tr "[:upper:]" "[:lower:]")" in
	                         "normal-quadrature") ENC_TYPE="0" ;; # Encoder type is "Normal Quadrature"
	                         "normal-quad") ENC_TYPE="0" ;; # Encoder type is "Normal Quadrature"
	                         "pulse-and-direction") ENC_TYPE="1" ;; # Encoder type is "Pulse and Direction"
	                         "pulse-and-dir") ENC_TYPE="1" ;; # Encoder type is "Pulse and Direction"
	                         "reverse-quadrature") ENC_TYPE="2" ;; # Encoder type is "Reverse Quadrature"
	                         "rev-quad") ENC_TYPE="2" ;; # Encoder type is "Reverse Quadrature"
	                         "reverse-pulse-and-direction") ENC_TYPE="3" ;; # Encoder type is "Reverse Pulse and Direction"
	                         "rev-pulse-and-dir") ENC_TYPE="3" ;; # Encoder type is "Reverse Pulse and Direction"
	                         *) ENC_TYPE="" ;; # Encoder type is undefined
                            esac
                            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage $0
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage $0
            exit 1
            ;;
    esac
done

if [ "$OPTIND" -le "$#" ]; then
    echo "Invalid argument at index '$OPTIND' does not have a corresponding option." >&2
    usage $0
    exit 1
fi
