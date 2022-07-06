#!/bin/bash

docker attach $1 --detach-keys="ctrl-a" | \
while read -r line;
do
   echo "$line" ;
   if [[ "$line" == *"push timemanager-api latest PUT"* || "$line" == *"push timemanager-client latest PUT"* ]]; then
    echo "Auto deploy !!"
    ./run db server client --prod -m "pull"
    ./run db server client --prod -m "up --build -d"
   fi
done
