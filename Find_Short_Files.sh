#!/bin/bash

echo "Let's find Short Movie file!"

cd /Volumes/HDD

log_name="short_movs.txt"

#echo "" > $log_name

files=()
while read file
    do
        files+=("${file}")
    done < <(find ./Video \
        -path './Video/Short' -prune -or \
        -type f -name .DS_Store -prune -or \
        -type f -name '*.jpg' -prune -or \
        -type f -print
    )
#echo "${files[@]}" > file_list.txt

echo "Total Files:${#files[@]}"

echo "press any key..."
read Wait

count=0

for file in "${files[@]}";
    do
        count=$(($count + 1))
        duration_time=$(ffprobe -i "$file" -show_entries format=duration -v quiet -of csv="p=0")
        time_number=${duration_time/.*}
        if [ "$time_number" -lt 180 ]; then
            :
            #echo $file >> $log_name
            mv "$file" ./Video/Short
        else
            :
        fi
        
        printf "\r$count / ${#files[@]}"
    done

echo " "
echo "Done!"
