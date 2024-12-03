#!/bin/bash

SITE="ntt.net"
POROG=100
FAILED=0

echo "Ping Start $SITE..."

while true; do
    PING_RES=$(ping -c 1 -W 1 "$SITE" 2>/dev/null)

    if [[ $? -ne 0 ]]; then
        ((FAILED++))
        echo "Ping failed! Count: $FAILED"   
    else
        TIME=$(echo "$PING_RES" | grep "round-trip" | awk -F'/' '{print $5}')
        CELL_TIME=${TIME%.*}
 

        if [[ $CELL_TIME -gt $POROG ]]; then
            echo "Ping time high: $CELL_TIME ms (predel: $POROG ms)."
        else
            echo "Ping is OK! time: $CELL_TIME ms."
        fi
        FAILED=0
    fi
        if [[ $FAILED -ge 3 ]]; then
        echo "3 Ping failed. Exit."
        break
        fi

    sleep 1
done

