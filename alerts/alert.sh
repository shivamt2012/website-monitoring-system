#!/bin/bash

URL=$1
EVENT=$2

ALERT_LOG="logs/alerts.log"

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if [ "$EVENT" = "DOWN" ]; then

	    MESSAGE="ALERT: $URL is DOWN"

    elif [ "$EVENT" = "RECOVERED" ]; then

	        MESSAGE="RECOVERY: $URL is UP"

	else

		    MESSAGE="$URL $EVENT"

fi

echo "$MESSAGE"

echo "$TIMESTAMP | $MESSAGE" >> "$ALERT_LOG"
