#!/bin/bash



# listen for messages c1
echo "Listening for carriage messages"


# time stamp

now=$(date)

# listen for messages  ---------------

mosquitto_sub -t "driver/carriage/#" | while read line
do
        echo "$now : $line"
# log file storing
        echo "$now : $line" >> log.txt
done

