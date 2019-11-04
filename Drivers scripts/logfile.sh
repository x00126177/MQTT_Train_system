#!/bin/bash

# log file to configure the amount of lines outputted by the log file

echo "Log file lines:"
read input

tail -f -n $input log.txt