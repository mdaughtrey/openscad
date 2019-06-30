#!/bin/bash

#grep SNAPDOME keyplate.brd | grep 'element name'  | sed -e 's/"//' 
grep SNAPDOME keyplate.brd | grep 'element name' | cut -d\" -f10,12 | sed -e 's/"/ /' | while read x y; do
    echo '<hole x="'${x}'" y="'${y}'" drill="7.62"/>'
done

#grep SNAPDOME keyplate.brd | egrep 'element name="[A-Z]?"' | egrep -o '[xy]?="[0-9\.-]*"' | tr "\ny" " y" | tr "x" "\nx" | tr -d 'x=' | tr -d y
