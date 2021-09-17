#!/usr/bin/env python3

import pdb

scale = 1.1
section_profile = [[0,0], [100,0], [145, 45], [145, 55],  [100, 100], [0,100]]
section_profile = [[0,0], [100,0], [100,50],[55,95],[55,105],[100,145],[100,195]]


ys = [x[0] for x in section_profile]
xs = [x[1] for x in section_profile]

avgy = sum(ys)/len(ys)
avgx = sum(xs)/len(xs)

ys = [y-avgy for y in ys]
xs = [x-avgx for x in xs]

ys = [round(y*scale) for y in ys]
xs = [round(x*scale) for x in xs]
result = [xx for xx in zip(ys,xs)]
pdb.set_trace()
pass
