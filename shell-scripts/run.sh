#!/usr/bin/env bash
now=$(date +"%T")
echo "Container Start Time : $now" >> /tmp/spark-start.txt
if [ -z "$LIVY_HOST" ]
then
   echo "LIVY_HOST not set" >> /tmp/run.log
else
   sed -i "s#{{LIVY_HOST}}#$LIVY_HOST#" ~/.sparkmagic/config.json
   sleep 2
   jupyter notebook
fi
