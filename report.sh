#!/bin/bash

LOG_FILE="logs/monitor.log"

echo "========== WEBSITE UPTIME REPORT =========="

for URL in $(awk -F'|' '{print $2}' "$LOG_FILE" | sort | uniq)
do
	    TOTAL=$(grep -c "$URL" "$LOG_FILE")

	        SUCCESS=$(grep "$URL" "$LOG_FILE" | grep -E "UP|SLOW|VERY_SLOW" | wc -l)

		    FAILURES=$(grep "$URL" "$LOG_FILE" | grep "DOWN" | wc -l)

		        UPTIME=$(echo "scale=2; ($SUCCESS/$TOTAL)*100" | bc)

			    echo
			        echo "Website : $URL"
				    echo "Total Checks : $TOTAL"
				        echo "Successful : $SUCCESS"
					    echo "Failures : $FAILURES"
					        echo "Uptime (%) : $UPTIME"
					done
