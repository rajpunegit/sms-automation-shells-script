#!/bin/bash

# Set the directory containing the text files with message details
directory="sms"

# Loop through each text file in the specified directory
for file in "$directory"/*.txt
do
    # Check if the current file is a regular file
    if [ -f "$file" ]
    then
        # Initialize a counter for tracking the current line in the file
        i=0

        # Loop through each line of the file
        while read -r line; do
            # Print the current line
            echo $line

            # Check if the line is not empty
            if [ -n "$line" ]; then
                # Use the counter to determine which variable to set
                if [ $i -eq 0 ]; then
                    # The first line contains the template ID
                    template_id=$line
                elif [ $i -eq 1 ];then
                    # The second line contains the recipient's mobile number
                    mobile=$line
                elif [ $i -eq 2 ];then
                    # The third line contains the message text
                    message=$line
                else
                    # Ignore any additional lines beyond the third line
                    echo $line
                fi
            fi

            # Increment the line counter
            i=$((i+1))
        done < $file

        # Remove any special characters from the template ID, mobile number, and message
        template_id="${template_id//[^[:alnum:] ]/}"
        mobile="${mobile//[^[:alnum:] ]/}"
        message="${message//[^[:alnum:]' ''-''_']/}"
        message=${message// /%20}

        # Remove the text file containing the message details
        if [ -e "$file" ]; then
            rm "$file"
        fi

        # Send the message using the specified API endpoint and message details
        echo "https:///sms/send?access_token=79187&to=${mobile}&message=${message}&service=T&sender=P&entity_id=12&template_id=${template_id}"
        curl --insecure "https:///sms/send?access_token=79187&to=${mobile}&message=${message}&service=T&sender=P&entity_id=12&template_id=${template_id}"
    fi
done
