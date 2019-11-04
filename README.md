# MQTT_Train_system
MQTT scripts to control a train and two carriages

*View in Raw*


Security for Cloud and IoT
Bash MQTT Intercom System

Contents
	Topics used
	Requirements met
	Drivers scripts
	Carriages scripts 
	Tests performed


Topics used
Driver/brakes
Driver/carriage
Driver/carriage/c1
Driver/carriage/c2

Requirements met
A driver will have a screen populated with 4 bash terminals to run the scripts. All the scripts are automated but the brake status console will ask for a desired amount of brake time from the driver in the case of an emergency. The logfile will also need to be told how many lines of data to output and constantly refresh to the driver.
The carriages will also be run through a screen. Three terminals will be needed to run the scripts. None will need to be manually operated unless the event of an emergency when the carriages need to come to a stop. The carriages can message the driver for enquiries or they can initiate the emergency brake handle if they come into any difficulty. the emergency brake handle can only be used every 30 seconds for both carriages. The driver can message back to the carriages too with individual messages or broadcast messages when announcing things such as the destination of the next stop. 

Driver (VM1) 10.10.0.5
Completed: driver_brake_status.sh
•	One window should be constantly be displaying the brake status, ON or OFF. This should start at OFF. It should change to ON if a message comes in from a carriage to activate the brakes. It should automatically change back to OFF after 10 seconds of being ON.

Completed: driver_incoming_messages.sh
•	One window should be displaying any incoming messages from carriages, the sending carriage number and the message text should be displayed

Completed: driver_message_carriages.sh
•	One window should allow the driver to send messages to carriages, the driver should be able to broadcast to ALL carriages or send message to just one carriage



Completed: logfile.sh
•	One window should be showing the log file content and should automatically update as messages are sent or received.

Carriages 1 and 2 (VM2 and VM3) 10.10.0.6 & 10.10.0.7
	Completed: carriage1/2_incoming_messages.sh
•	One window should be displaying any incoming messages from the driver, the message text should be displayed
Completed: carriage1/2_send_messages.sh
•	One window should allow a passenger to send messages to the driver
Completed: carriage1/2_EBH.sh
•	One window should allow a passenger to activate the emergency brakes by sending a message to the control system on VM1.

Drivers Scripts 
driver_brake_status.sh
This script allows the driver to show the current status of the brakes. When the script is first ran it shows the current status of the brakes which is off and it also prompts the driver to input the amount of braking time he requires in the case of an emergency. It shows the status of the brakes until it receives a message from a carriage’s emergency handbrake that then messages all of the carriages that the train is coming to a stop and the amount of time it will be braking for. This is all logged in the logfile.txt with a timestamp of the event. It then stops the train for the period specified by the driver. When the braking time is over the brake status is then prompted again after it has come to a stop.

driver_incoming_messages.sh
This script shows incoming messages from the two carriages. The date and time are prompted, followed by the carriage, followed by the message sent to the driver. 

driver_message_carriages.sh
Allows the driver to message both carriages with the choice of either messaging a carriage individually or by broadcasting a message to them both.




logfile.sh
This allows the driver to configure the amount of log entries he wants to list from the log.txt file. Every message that is sent and received by the driver is stored here in case of review. It refreshes with every new message sent and received by the driver.

Carriage1/2 Scripts
carriage1/2_incoming_messages.sh
This waits for messages sent by the driver. It can only receive messages from the driver. The types of messages it accepts are individual messages, a broadcast message or an alert about the brakes being initiated. The message format is as follows: date, time, sender (Driver) and then the message. If the brakes are initiated the carriage is told the amount of time also that the brakes will be initiated for. 

carriage1/2_send_message.sh
Allows the carriages to individually message the driver. A carriage cannot message another carriage nor can it broadcast to all topics.

carriage1/2_EBH.sh
When ran, the carriage is prompted with a brief description as to the penalties that can be issued if the emergency brake handle is used improperly. The lever is initiated with the number 1 and publishes to the drivers brake controller to stop the train. The user is then prompted again to initiate the brakes but is not necessary for the carriage to do so as the train is coming to a stop anyway.

Tests performed
1.	Can the Driver message carriages individually?
•	Done with driver_message_carriages.sh and carriage1/2_incoming_messages.sh
•	I initiated the individual messaging feature by typing 1
•	I chose the first carriage by choosing number 1 again
•	I was then prompted to enter my message which I did followed by enter
•	The message was delivered successfully to carriage 1
•	I then repeated the same steps for carriage 2
•	I tried to attack the options prompted and typed 3 when asked to choose to broadcast or individually message. This did not let me progress as "Incorrect choice - try again" was returned followed by the script looping and asking for another option instead



2.	Can the Driver broadcast messages?
•	Done with driver_message_carriages.sh and carriage1/2_incoming_messages.sh
•	With this I chose the broadcast option for messaging the carriages. I entered my message and it published successfully
•	Again, I tried to test the IFs by choosing an option not prompted. It did not let me continue

3.	Can carriages message the driver individually?
•	I tested this on the carriage1/2_send_message.sh script
•	I used both VM2 and VM3 to message the driver
•	There were no other options given to message the driver so nothing could be bypassed 

4.	Does the Emergency Brake Handle work for both carriages?
•	Done with driver_brake_status.sh, carriage1/2_EBH.sh, carriage1/2_incoming_messages.sh
•	I ran the script as it was meant to be by initiating the handle with 1
•	This published to the drivers brake console, forcing it to initiate the brakes and changing the BRAKE_STATUS to ‘ON’
•	This message and the brake time were then published to the carriages incoming messages scripts. This worked successfully
•	When I repeatedly initiated the brakes by hitting 1 multiple times, the brake time queued up on itself until all instances finished. This is not a big problem though as once the brakes have been initiated, the train should come to a complete stop. As a reinforcement in case of a brute force attempt on the system, I inputted a sleep time on the carriages emergency brake handle to give the system 30 seconds before it can ask the brake console to stop again
•	I tried to access the system by inputting another value instead of 1, this outputted incorrect value and prompted me to input 1 again if the emergency brake handle was needed

5.	Does the logfile script populate properly?
•	Done with logfile.sh
•	This prompts the driver and asks how many lines of the appended data they would like to see
•	Any number can be inputted here and the system shouldn’t be affected by it
•	The system will refresh every time a new entry goes into the log file

6.	Testing carriages inboxes, the EBH, timestamping and the drivers brake controller
•	Done with carriage1/2_incoming_messages.sh, carriage_EBH.sh, driver_brake_status.sh and logfile.sh
•	Did this to see if all operations were running as needed
•	All ran smoothly and showed the logging of the inbound and outbound messages correctly along with the changing of the BRAKE_STATUS variable

