#!/usr/bin/python3

import numpy
#import imageio
import imageio
from PIL import Image
import collections
import pdb

def loadBmp():
    plotlist = collections.deque()
    bmp = numpy.rot90(imageio.imread("./glasses2.bmp"))
    offset=0
    #mult = 16
    index = 0
    inc = int(3025/bmp.shape[0])
    mult = inc

    #print("polygon(points=[[0,0],[10,0],")
    print("polygon(points=[[0,0],")
    for ii in bmp:
        whites = numpy.argwhere(ii)
        if 0 == len(whites):
            continue
            #print("[",int(index),",0],",sep="",end=""),
        plotlist.append((index, whites[0][0]))
        plotlist.appendleft((index, whites[-1][0]))
        #else:
        #    print("[",int(index),",",first1[0][0]*mult+offset,"],",sep="",end=""),
        index = index+inc
    for xx in plotlist:
        print("[",xx[0],",",xx[1],"],",sep="",end="")
    print("],convexity=1);")
    #print("[",int(index),",0],[",int(index)+10,",0]],convexity=1);",sep="")

loadBmp()
