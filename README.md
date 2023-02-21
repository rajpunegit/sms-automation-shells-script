SMS Sending Script
This shell script sends SMS messages using a remote API. It looks for text files containing information about each message in a specified directory and sends each message to the intended recipient.

Requirements
To use this script, you need:

Bash shell
curl command
SMS API access token
Usage
Set the directory containing the text files containing the messages to be sent.

bash
Copy code
directory="sms"
Make the script executable.

bash
Copy code
chmod +x send_sms.sh
Run the script.

bash
Copy code
./send_sms.sh
Ensure the script has proper permission. Run chmod +x send_sms.sh if necessary.

The script will read each text file in the specified directory and send a message for each file.

bash
Copy code
for file in "$directory"/*.txt
do
   ...
done
Each text file must contain four lines:

bash
Copy code
<template_id>
<mobile>
<message>
<additional information>
The first line contains the template ID for the message.
The second line contains the recipient's mobile number.
The third line contains the message text.
The fourth line can contain additional information and will be ignored by the script.
The script will then clean up the text file and send the message using curl.

bash
Copy code
rm "$file"
curl --insecure "https:///sms/send?access_token=79187&to=${mobile}&message=${message}&service=T&sender=P&entity_id=12&template_id=${template_id}"
The message will be sent using the specified API endpoint with the provided access token and message details.

Note
This is a basic script that can be used as a starting point for sending SMS messages using an API. Modify the script according to your needs and requirements.
Replace the API endpoint with the appropriate endpoint for your SMS service.
This script does not handle errors or exceptions, so it should be used with care.