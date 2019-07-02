#!/bin/bash
echo "holecoords=["
cat keylayout.raw | cut -d' ' -f2,6,7  | cut -d\" -f4,6 | tr \" ' ' | while read x y
do
    echo "["$(echo "scale=2;${x}/25.4*1000" | bc -q)","$(echo "scale=2;${y}/25.4*1000" | bc -q)"],"
done
echo "];"

