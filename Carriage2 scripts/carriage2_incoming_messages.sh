#!/bin/bash
echo "CTRL + c to end"


# carriage 2 listening for driver messages
echo "Listening for Driver messages"
mosquitto_sub -t "driver/carriage/c2"




