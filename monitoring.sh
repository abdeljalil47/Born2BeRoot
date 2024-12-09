#!/bin/bash
arch=$(uname -a)
pcpu=$(grep "physical id" /proc/cpuinfo | wc -l)
vcpu=$(grep "^processor" /proc/cpuinfo | wc -l)
aram=$(free --mega | grep "Mem" | awk '{print $2}')
uram=$(free --mega | grep "Mem" | awk '{print $3}')
pram=$(free | grep "Mem" | awk '{printf("%.2f", $3/$2*100)}')
adisk=$(df -BG | grep -v '/boot' | grep '^/dev/' | awk '{at+=$2}END{print at}')
udisk=$(df -BM | grep -v '/boot' | grep '^/dev/' | awk '{ut+=$3}END{print ut}')
pdisk=$(df -BM | grep -v '/boot' | grep '^/dev/' | awk '{ut+=$3} {ft+=$2}END{printf("%d", ut/ft*100)}')
cpu=$(top -bn1 | awk '{NR>7 {ft+=$9}END{print ft}}')
rebot=$(uptime -s | cut -d: -f1,2)
lvm=$(lsblk | grep 'lVM' | wc -l | awk '{if ($1>="1") {print "yes"}}')
acont=$(ss --tcp | grep '^ESTAB' | wc -l | awk '{if($1>="1") {print $1}}')
nlog=$(who | wc -l)
ip=$(hostname -I)
mac=$(ifconfig | grep -w "ether" | awk '{print $2}')
csud=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

wall "
    #Architecture: $arch
    #CPU physical : $pcpu
    #vCPU : $vcpu
    #Memory Usage: $uram/${aram}MB ($pram%)
    #Disk Usage: $udisk/${adisk}Gb ($pdisk%)
    #CPU load: $cpu
    #Last boot: $rebot
    #LVM use: $lvm
    #Connections TCP : $acont
    #User log: $nlog
    #Network: IP $ip ($mac)
    #Sudo : $csud cmd
    "