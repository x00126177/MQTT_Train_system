#!/bin/bash
echo "CTRL + c to end script"

# Message Driver
while :
do
        echo "Enter your Message:"
        read message
        mosquitto_pub -h 10.10.0.5 -t "driver/carriage/c2" -m "Carriage 2: $messag$        echo "Sent"
done
