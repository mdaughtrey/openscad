#!/bin/bash
cat keylayout.raw | cut -d' ' -f2,6,7  | cut -d\" -f4,6 | tr \" ' ' | while read x y
do
    echo "translate(["$(echo "scale=2;${x}/25.4*1000" | bc -q)","$(echo "scale=2;${y}/25.4*1000" | bc -q)",0])"
    echo 'circle(KEYCUTOUTR, $fn=96);'
done

