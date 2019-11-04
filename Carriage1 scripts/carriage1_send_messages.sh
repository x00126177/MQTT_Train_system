#!/bin/bash
echo "CTRL + c to end script"

# Message Driver
while :
do
        echo "Enter your Message:"
        read message
        mosquitto_pub -h 10.10.0.5 -t "driver/carriage/c1" -m "Carriage 1: $messag$        echo "Sent"
done