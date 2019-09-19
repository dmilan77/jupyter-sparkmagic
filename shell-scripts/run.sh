#!/usr/bin/env bash
now=$(date +"%T")
echo "Container Start Time : $now" 
echo "LIVY_HOST=$LIVY_HOST"
if [ -z "$LIVY_HOST" ]
then
   echo "LIVY_HOST not set" 
else
   sed -i "s#{{LIVY_HOST}}#$LIVY_HOST#" /home/spark/.sparkmagic/config.json
   sleep 2
   echo "$(cat /home/spark/.sparkmagic/config.json)"
   jupyter notebook --ip=0.0.0.0 --port=8888
fi

