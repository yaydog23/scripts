#!/bin/bash
current=`date`
path="/path"
modify=`date -r $path`
twohourago=`date -d '2 hour ago'`

if [ "$modify" \< "$twohourago" ]
then
echo "NOACTIVITY" | mail -s "NO  ACTIVITY" emailaddress
fi 


