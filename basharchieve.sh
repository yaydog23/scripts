#!/bin/bash

BASE_DIR=/path

## Find those files that are older than a month
find "$BASE_DIR" -maxdepth 1 -mtime +30 -type f  | 
 while IFS= read -r file; do
    ## Get the file's modification year
    year="$(date -d "$(stat -c %y "$file")" +%Y)"
    ## Get the file's modification month
    month="$(date -d "$(stat -c %y "$file")" +%b)"

    [[ ! -d "$BASE_DIR/$year/$month" ]] && mkdir -p "$BASE_DIR/$year/$month"; 

    ## Move the file
    mv "$file" "$BASE_DIR/$year/$month"
done






