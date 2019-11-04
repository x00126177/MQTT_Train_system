#!/bin/bash

# Brake Status ----------------------------------
while :
do
        BRAKE_STATUS='OFF'
        echo "Brakes are: $BRAKE_STATUS"

# Brake timer
        echo "How long do you want to brake in case of an emergency? (e.g. 10 seconds)"
        echo "Please input your time in seconds:"
        read brake_time
   ^_ Go To Line   M-E Redo
# Time stamp
now=$(date)

# activate brakes from message

mosquitto_sub -t "driver/brakes" | while read line
do

# update log of message that has been received
                echo "$now : To Driver : Turn Brakes on" >> log.txt

# updating brakes status variable
                BRAKE_STATUS=$line
                echo "Brakes are: $BRAKE_STATUS"

# letting the carriages know about the brakes
                echo "Messaging other Carriages"
                mosquitto_pub -h 10.10.0.6 -t "driver/carriage/c1" -m "$now : Brakes have been turned $BRAKE_STATUS"
                mosquitto_pub -h 10.10.0.7 -t "driver/carriage/c2" -m "$now : Brakes have been turned $BRAKE_STATUS"

# sending messages to logfile
                echo "$now : To Carriage 1 : Brakes have been turned on" >> log.txt
                echo "$now : To Carriage 2 : Brakes have been turned on" >> log.txt

# messaging carriages about timer
                echo "Messaging carriages the BRAKE TIME "
                mosquitto_pub -h 10.10.0.6 -t "driver/carriage/c1" -m "$now : Activated for $brake_time seconds"
                mosquitto_pub -h 10.10.0.7 -t "driver/carriage/c2" -m "$now : Activated for $brake_time seconds"

# update logs
                echo "$now : To Carriage 1 : Activated for $brake_time seconds" >> log.txt
                echo "$now : To Carriage 1 : Activated for $brake_time seconds" >> log.txt

# loop for brake timer
                for (( i = $brake_time; i>0; i-- ));
                        do
                                printf "$i\n" && sleep 1;
                        done
# reflecting brake status
                BRAKE_STATUS='OFF'
                echo "Brakes are: $BRAKE_STATUS"

done
done