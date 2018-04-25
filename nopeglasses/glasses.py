#!/usr/bin/python3

import numpy
#import imageio
import imageio
from PIL import Image
import pdb
import collections

def loadBmp1():
    #pdb.set_trace()
    bmp = numpy.rot90(imageio.imread("./glasses1.bmp"))
    offset=-100
    #mult = 16
    index = 0
    inc = int(3025/bmp.shape[0])
    mult = inc

    file1 = open("./glasses1.dat", "w")
    max = 0
    #print("polygon(points=[[0,0],[10,0],")
    print("polygon(points=[", sep="", end="", file=file1)
    for ii in bmp:
        first1 = numpy.argwhere(ii)
        if 0 == len(first1):
            continue
            #print("[",int(index),",0],",sep="",end="",file=file1),
        else:
            val = first1[0][0]*mult+offset
            print("[",int(index),",",val,"],",sep="",end="",file=file1),
            if val > max: max = val
        index = index+inc
    print("[",int(index-inc),",",max+500,"],[0,",max+500,"]],convexity=1);",sep="",file=file1)

def loadBmp2():
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
    file2a = open("glasses2a.dat", "w")
    file2b = open("glasses2b.dat", "w")
    print("polygon(points=[",sep="",end="",file=file2a)
    print("polygon(points=[",sep="",end="",file=file2b)
    maxa = 0
    maxb = 0
    for ii in bmp:
        whites = numpy.argwhere(ii)
        if 0 == len(whites):
            continue
            #print("[",int(index),",0],",sep="",end=""),
        vala = whites[0][0]*mult
        valb = whites[-1][0]*mult
        plotlist1.append((index, vala))
        plotlist2.append((index, valb))
        if vala > maxa: maxa = vala
        if valb > maxb: maxb = valb
#        plotlist1.appendleft((index, whites[-1][0]))
        #else:
        #    print("[",int(index),",",first1[0][0]*mult+offset,"],",sep="",end=""),
        index = index+inc
    for xx in plotlist1:
        print("[",xx[0],",",xx[1],"],",sep="",end="", file=file2a)
    for xx in plotlist2:
        print("[",xx[0],",",xx[1],"],",sep="",end="", file=file2b)

    print("[",int(index-inc),",",maxa+500,"],[0,",maxa+500,"]],convexity=1);",sep="",file=file2a)
    print("[",int(index-inc)+500,",1000],[500,1000]],convexity=1);",sep="",file=file2b)

    #print("],convexity=1);", sep="", file=file2a)
    #print("],convexity=1);", sep="", file=file2b)
    #print("[",int(index),",0],[",int(index)+10,",0]],convexity=1);",sep="")

loadBmp1()
loadBmp2()
