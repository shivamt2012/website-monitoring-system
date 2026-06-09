#!/bin/bash

CONFIG_FILE="config.txt"
LOG_FILE="logs/monitor.log"

STATE_DIR="alerts/state"
ALERT_SCRIPT="alerts/alert.sh"

MAX_RETRIES=2
RETRY_DELAY=1

while read -r URL
do
	    # Skip empty lines
	        [ -z "$URL" ] && continue
		echo "Checking $URL ..."

		    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

		        ATTEMPT=1
			    SUCCESS=0

			        while [ $ATTEMPT -le $MAX_RETRIES ]
					    do
						            RESULT=$(curl -L -s -o /dev/null \
								                --connect-timeout 3 \
										            -w "%{http_code} %{time_total}" \
											                "$URL")

							            STATUS=$(echo "$RESULT" | awk '{print $1}')
								            RESPONSE_TIME=$(echo "$RESULT" | awk '{print $2}')

									            if [ "$STATUS" -ge 200 ] 2>/dev/null && [ "$STATUS" -lt 400 ]; then
											                SUCCESS=1
													            break
														            fi

															            ((ATTEMPT++))
																            sleep $RETRY_DELAY
																	        done

																		    # Determine final state
																		        if [ $SUCCESS -eq 1 ]; then

																				        if (( $(echo "$RESPONSE_TIME > 3" | bc -l) )); then
																						            STATE="VERY_SLOW"

																							            elif (( $(echo "$RESPONSE_TIME > 1" | bc -l) )); then
																									                STATE="SLOW"

																											        else
																													            STATE="UP"
																														            fi

																															        else
																																	        STATE="DOWN"
																																		    fi

																																		        # ==========================
																																			    # Alert State Tracking
																																			        # ==========================

																																				    HOSTNAME=$(echo "$URL" | sed 's|https\?://||' | cut -d'/' -f1)

																																				        STATE_FILE="$STATE_DIR/$HOSTNAME.state"

																																					    if [ ! -f "$STATE_FILE" ]; then
																																						            echo "UNKNOWN" > "$STATE_FILE"
																																							        fi

																																								    PREVIOUS_STATE=$(cat "$STATE_FILE")

																																								        # Alert only on transition to DOWN
																																									    if [ "$PREVIOUS_STATE" != "DOWN" ] && [ "$STATE" = "DOWN" ]; then
																																										            "$ALERT_SCRIPT" "$URL" "DOWN"
																																											        fi

																																												    # Recovery alert
																																												        if [ "$PREVIOUS_STATE" = "DOWN" ] && [ "$STATE" != "DOWN" ]; then
																																														        "$ALERT_SCRIPT" "$URL" "RECOVERED"
																																															    fi

																																															        echo "$STATE" > "$STATE_FILE"

																																																    # ==========================
																																																        # Logging
																																																	    # ==========================

																																																	        echo "$TIMESTAMP | $URL | $STATE | Status: $STATUS | Time: ${RESPONSE_TIME}s | Attempts: $ATTEMPT" >> "$LOG_FILE"

																																																	done < "$CONFIG_FILE"
