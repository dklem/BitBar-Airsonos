#!/bin/bash

# Get current Airsonos status, and start/stop
#
# <bitbar.title>Airsonos</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>David Klem</bitbar.author>
# <bitbar.author.github>dklem</bitbar.author.github>
# <bitbar.desc>Get current Airsonos status. Start / Stop the service</bitbar.desc>
# <bitbar.dependencies>node.js, airsonos</bitbar.dependencies>
# <bitbar.image>https://bandpass.org/projects/airsonos-bitbar.jpg<//bitbar.image>
# <bitbar.abouturl>https://bandpass.org/projects/airsonos-bitbar</bitbar.about.url>

## Typical Method
# ps aux | egrep 'node.*airsonos' | grep -v "grep" | wc -l

## Using [] trick to elimintate grep line in ps output
# ps aux | egrep '[n]ode.*airsonos' | wc -l

pid=`ps aux | egrep '[n]ode.*airsonos' | awk '{print $2}'`
isrunning=`ps aux | egrep '[n]ode.*airsonos' | wc -l`
touch /tmp/airsonos.log

if [ "$1" = 'start' ]; then
	# `which airsonos` | tee /tmp/airsonos.log &
	`which airsonos` > /tmp/airsonos.log &
fi

if [ "$1" = 'stop' ]; then
	`which kill` $pid
fi

echo "🎶"
echo '---'
if [ $isrunning == 1 ]; then 
	# Running
	echo "Stop Airsonos | bash=$0 param1=stop terminal=false"
else
	# Not Running
	echo "Start Airsonos | bash=$0 param1=start terminal=true" 
fi
echo '---'

IFS=('\n'); clientlist=( $(egrep @ /tmp/airsonos.log | cut -d '(' -f1) )
echo $clientlist