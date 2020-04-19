#!/bin/bash
# A Simple Shell Script To Kill user sessions older than 24 hour
# Yigit Aydog - 26/Dec/2019
ps -eo pid,etimes,comm,user,tty | grep cxmnmain | awk '{if ($2>86400) print $1}' >> /root/sessionid.txt
for id in `more /root/sessionid.txt` ; do
kill -9 $id
done
rm -rf /root/sessionid.txt

