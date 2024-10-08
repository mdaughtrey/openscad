#!/usr/bin/python3

import numpy
#import imageio
import imageio
from PIL import Image
import collections
import pdb

def loadBmp():
    plotlist1 = collections.deque()
    plotlist2 = collections.deque()
    bmp = numpy.rot90(imageio.imread("./glasses2.bmp"))
    offset=0
    #mult = 16
    index = 0
    inc = int(3025/bmp.shape[0])
    #inc = 1
    mult = inc

    #print("polygon(points=[[0,0],[10,0],")
    print("polygon(points=[[0,0],")
    for ii in bmp:
        whites = numpy.argwhere(ii)
        if 0 == len(whites):
            continue
            #print("[",int(index),",0],",sep="",end=""),
        plotlist1.append((index, whites[0][0]*mult))
        plotlist2.appendleft((index, whites[-1][0]*mult))
#        plotlist1.appendleft((index, whites[-1][0]))
        #else:
        #    print("[",int(index),",",first1[0][0]*mult+offset,"],",sep="",end=""),
        index = index+inc
    for xx in plotlist1:
        print("[",xx[0],",",xx[1],"],",sep="",end="")
    for xx in plotlist2:
        print("[",xx[0],",",xx[1],"],",sep="",end="")
    print("],convexity=1);")
    #print("[",int(index),",0],[",int(index)+10,",0]],convexity=1);",sep="")

loadBmp()
