#!/bin/bash
while :
do
echo "Emergency Brake Handle"
echo "only use in case of EMERGENCY"
echo "A fine of €500 will be issued to those who do activate without reason"
echo "from the Transport of Ireland"
echo "Pull lever by typing 1 and hitting enter"
read lever

# activate EBH
if [ $lever = 1 ]
then
        mosquitto_pub -h 10.10.0.5 -t "driver/brakes" -m "ON"
	sleep 30;
else
        echo "Incorrect Input"
fi
done