#!/bin/bash
#
cd Addadshashanammu

while [ "$(echo $?)" == "0" ]; do 
    nextFoldertogetin=$(ls)
    cd $nextFoldertogetin 2>/dev/null
done

file=$(ls)


echo ""

echo "FLAG------------------"

./$file

echo "END ------------------"
