#!/bin/bash

# This script mean to:
# - put package for installation in install folder
# - run AEM
# - wait until the installation is done
# - close AEM instance

function load_proc() {
  PROC=$(top -b -n 1 -p $JAVA_PID | head -8 | tail -1 | awk '{print $9}')
}

function find_java_proc() {
  JAVA_PID=$(ps -o pid= --ppid $AEM_PID | head -1)
}

# run
echo "Starting AEM instance in $(pwd)"
$(pwd)/crx-quickstart/bin/run.sh &

AEM_PID=$!

echo "AEM started with $AEM_PID"

sleep 30 # let the instance start - it has to run properly process
find_java_proc

echo "Checking PROC"
load_proc
echo "PROC: $PROC"

ATTEMPTS=0

while [ $ATTEMPTS -lt 4 ]; do
  sleep 2
  load_proc
  ATTEMPTS=$(echo $PROC $ATTEMPTS | awk '{v = $1 > 10 ? 0 : $2 + 1; print v}')
  echo "PROC: $PROC"
done

echo "Stopping AEM instance"

$(pwd)/crx-quickstart/bin/stop

echo "Waiting ultil it sleeps forever"

while kill -0 $AEM_PID; do
  sleep 1
done

echo "Done!"
