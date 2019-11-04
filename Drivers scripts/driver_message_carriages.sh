#!/bin/bash

echo "CTRL + c to end script"
while :
do

echo "Choose an option using the number associated to it"
echo "1. Message an individual carriage"
echo "2. Broadcast a message"
read input

# date timestamp

now=$(date)


# individual carriage message
if [ $input = 1 ]
then
        echo "Which carriage would you like to message? 1 or 2:"
        read carriage

        if [ $carriage = 1 ]
        then
                echo "Enter your message"
                read message
                echo "$now : To Carriage $carriage: $message" >> log.txt
                mosquitto_pub -h 10.10.0.6 -t "driver/carriage/c$carriage" -m "$now : Driver: $message"
                echo "Sent"
        elif [ $carriage = 2 ]
        then
                echo "Enter your message"
                read message
                echo "$now : To Carriage $carriage: $message" >> log.txt
                mosquitto_pub -h 10.10.0.7 -t "driver/carriage/c$carriage" -m "$now : Driver: $message"
                echo "Sent"
        else
                echo "Invalid Carriage Number"
        fi

# broadcast to all carriages
elif [ $input = 2 ]
then
        echo "Enter your message followed by enter:"
        read broad_message
        echo "$now : Broadcast message: $broad_message" >> log.txt
        mosquitto_pub -h 10.10.0.6 -t "driver/carriage/c1" -m  "$now : Driver: $broad_message"
        mosquitto_pub -h 10.10.0.7 -t "driver/carriage/c2" -m  "$now : Driver: $broad_message"
        echo "Sent"
else
        echo "Incorrect choice - Try again"
fi
done