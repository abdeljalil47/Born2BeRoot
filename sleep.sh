#!/bin/bash
min=$(uptime -s | awk '{print $2}')
sec=$(uptime -s | awk '{print $3}')
sle=$(sec+min%10*100)
sleep $sle