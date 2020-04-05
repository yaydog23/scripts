#!/bin/bash

BASE_DIR=/opt/lsy/netline/schedops/telex/transmit



## Find those files that are older than a month
find "$BASE_DIR" -maxdepth 1 -mtime +30 -type f  | 
 while IFS= read -r file; do
    ## Get the file's modification year
    year="$(date -d "$(stat -c %y "$file")" +%Y)"
    ## Get the file's modification month
    month="$(date -d "$(stat -c %y "$file")" +%b)"

    ## Create the directories if they don't exist. The -p flag
    ## makes 'mkdir' create the parent directories as needed so
    ## you don't need to create $year explicitly.
    [[ ! -d "$BASE_DIR/$year/$month" ]] && mkdir -p "$BASE_DIR/$year/$month"; 

    ## Move the file
    mv "$file" "$BASE_DIR/$year/$month"
done






