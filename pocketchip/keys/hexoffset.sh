#!/bin/bash

cat hexcutout.brd | cut -d\" -f2,4,6,8 | tr '"' ' ' | while read x1 y1 x2 y2
do
    echo x1 $x1 y1 $y1 x2 $x2 y2 $y2
done
