#!/bin/sh -

EXEC="$1"

"$EXEC">test.log &
SERVER_PID=$!
echo SERVER_PID: $SERVER_PID

# Create some clients in a background shell process.
{
    # Give the server some time to start up.
    sleep 0.3

    for COUNT in {1..50}; do
        curl -s localhost:8080/ >/dev/null
        curl -s localhost:8080/x >/dev/null
        curl -s localhost:8080/hello >/dev/null
        sleep 0.01
    done
} &
CLIENTS_PID=$!
echo CLIENTS_PID $CLIENTS_PID

# Periodically collect memory usage information.
for COUNT in {1..50}; do
    ps -o rss,size,vsize $SERVER_PID | tail --lines 1 -
    sleep 0.01
done

kill -9 $SERVER_PID
kill -9 $CLIENTS_PID
