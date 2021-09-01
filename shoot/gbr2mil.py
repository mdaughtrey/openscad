#!/usr/bin/python3

import re
import pdb
import re
import sys

lines = open(sys.argv[1], 'r').readlines()
coords = [jj.strip('\n') for jj in lines if jj[0] == "X"]
#matches = [re.search('X([0-9\.]+)Y([0-9\.]+)D03', line).groups() for line in lines[1:]]
#pdb.set_trace()
matches = [re.search('X(\d+)Y(\d+)', line).groups() for line in lines[1:]]

#tool = re.search('([0-9\.]+)X([0-9\.]+)',lines[0].split(',')[1]).groups()
reline = lines[0].split(',')

if "R" == reline[0][-1]:
    tool = re.search('([0-9\.]+)X([0-9\.]+)',reline[1]).groups()
    tool = [round(float(tool[0])/25.4*1000), round(float(tool[1])/25.4*1000)]
    tooltext = (f'square([{tool[0]}, {tool[1]}], center=true);')

if "C" == reline[0][-1]:
    tool = re.search('([0-9\.]+)\*', reline[1]).groups()
    tool = round(float(tool[0])/25.4*1000)
    tooltext = (f'circle({tool}/2, $fn=96);')


for (x, y) in matches:
    print(f'translate([{round(int(x)/254)}-1970/2,{round(int(y)/254)}-3940/2,60])')
    print(tooltext)

#map (lambda x: f'{x[0]/254000*1000},{x[1]/254000*1000}', matches)
