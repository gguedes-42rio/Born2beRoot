#!/bin/bash
MEMORY=$(free -m | awk 'FNR == 2 {printf("%i/%iMB (%.2f%%)", $3, $2, ($3/$2)*100)}')
DISK=$(df --total -m | grep total | awk '{printf("%i/%iGb (%i%%)", $3, $2/1000, ($3/$2)*100)}')
LVM=$(
    if grep -q /dev/mapper/ /etc/fstab
    then echo "yes"
    else echo "no"
    fi
)

wall "#Architecture: $(uname -a)
#CPU physical : $(grep 'physical id' /proc/cpuinfo | wc -l)
#vCPU : $(grep processor /proc/cpuinfo | wc -l)
#Memory Usage: ${MEMORY}
#Disk Usage: ${DISK}
#CPU load: $(top -b -n 1 | awk 'FNR == 3 {print $2}')%
Last boot: $(who -b | awk '{printf("%s %s", $3, $4)}')
LVM use: ${LVM}
Connections TPC : $(netstat | grep ESTABLISHED | wc -l) ESTABLISHED
User log: $(who | awk '{print $1}' | sort | uniq | wc -l)
#Network: IP $(hostname -I)($(ip a | awk 'FNR == 8 {print $2}'))
#Sudo : $(journalctl -q -t sudo | grep COMMAND | wc -l) cmd"
