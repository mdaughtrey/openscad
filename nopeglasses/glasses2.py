#!/usr/bin/python3

import numpy
#import imageio
import imageio
from PIL import Image
import pdb

def loadBmp():
    bmp = numpy.rot90(imageio.imread("./glasses2.bmp"))
    offset=0
    #mult = 16
    index = 0
    inc = int(3025/bmp.shape[0])
    mult = inc

    #print("polygon(points=[[0,0],[10,0],")
    print("polygon(points=[[0,0],")
    for ii in bmp:
        first1 = numpy.argwhere(ii)
        if 0 == len(first1):
            print("[",int(index),",0],",sep="",end=""),
        else:
            print("[",int(index),",",first1[0][0]*mult+offset,"],",sep="",end=""),
        index = index+inc
    print("[",int(index),",0],[",int(index)+10,",0]],convexity=1);",sep="")

loadBmp()
