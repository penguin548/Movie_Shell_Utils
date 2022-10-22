#!/bin/bash

echo "Let's find UHD file!"

cd /Volumes/HDD

log_name="over4k.txt"

#echo "" > $log_name

files=()
while read file
    do
        files+=("${file}")
    done < <(find ./Video \
        -path './Video/Over_UHD' -prune -or \
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
        ffmpeg_string=$(ffmpeg -i "$file" 2>&1 | grep -E 'Stream')
        dimention=$(echo $ffmpeg_string | grep -E -o '[0-9]{2,}x[0-9]+' | head -1)
        width=${dimention%x*}
        heigt=${dimention#*x}
        number=$((width * heigt))
        if [ "$number" -gt 8000000 ]; then
            #echo $file >> $log_name
            mv "$file" ./Video/Over_UHD
        else
            :
        fi
        
        printf "\r$count / ${#files[@]}"
    done

echo " "
echo "Done!"
