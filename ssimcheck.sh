#!/bin/bash
# A Simple Shell Script To Track ssim activity
# Yigit Aydog - 06/Jan/2020
current=`date`
path="/opt/lsy/netline/schedops/import/ssim/incoming"
modify=`date -r $path`
twohourago=`date -d '2 hour ago'`

if [ "$modify" \< "$twohourago" ]
then
echo "Please consult netline" | mail -s "NO SSIM ACTIVITY" yaydog@corendon-airlines.com
fi 


