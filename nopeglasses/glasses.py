#!/usr/bin/python3

import numpy
#import imageio
import imageio
from PIL import Image
import pdb
import collections

def bres(start, end):
    """Bresenham's Line Algorithm
    Produces a list of tuples from start and end
    >>> points1 = get_line((0, 0), (3, 4))
    >>> points2 = get_line((3, 4), (0, 0))
    >>> assert(set(points1) == set(points2))
    >>> print points1
    [(0, 0), (1, 1), (1, 2), (2, 3), (3, 4)]
    >>> print points2
    [(3, 4), (2, 3), (1, 2), (1, 1), (0, 0)]
    """
    # Setup initial conditions
    x1, y1 = start
    x2, y2 = end
    dx = x2 - x1
    dy = y2 - y1
    # Determine how steep the line is
    is_steep = abs(dy) > abs(dx)
    # Rotate line
    if is_steep:
        x1, y1 = y1, x1
        x2, y2 = y2, x2
    # Swap start and end points if necessary and store swap state
    swapped = False
    if x1 > x2:
        x1, x2 = x2, x1
        y1, y2 = y2, y1
        swapped = True
    # Recalculate differentials
    dx = x2 - x1
    dy = y2 - y1
    # Calculate error
    error = int(dx / 2.0)
    ystep = 1 if y1 < y2 else -1
    # Iterate over bounding box generating points between start and end
    y = y1
    points = []
    for x in range(x1, x2 + 1):
        coord = (y, x) if is_steep else (x, y)
        points.append(coord)
        error -= abs(dy)
        if error < 0:
            y += ystep
            error += dx
    # Reverse the list if the coordinates were swapped
    if swapped:
        points.reverse()
    return points

def loadBmp(input, output):
    #bmp = numpy.rot90(imageio.imread("./glasses1.bmp"))
    bmp = numpy.rot90(imageio.imread(input))
    offset=-100
    index = 0
    inc = int(3025/bmp.shape[0])
    mult = inc

    #file1 = open("./glasses1.dat", "w")
    file1 = open(output, "w")
    max = 0
    print("polygon(points=[", sep="", end="", file=file1)
    for ii in bmp:
        first1 = numpy.argwhere(ii)
        if 0 == len(first1):
            continue
            #print("[",int(index),",0],",sep="",end="",file=file1),
        else:
            val = first1[0][0]*mult+offset
            if val == -100: val = 80
            if 1 == len(first1):
                print("[",index,",",val,"],",sep="",end="",file=file1)
            else:
                valnext = first1[1][0]*mult+offset
                for dd in bres((index, val),(index+inc,valnext)):
                    print("[",dd[0],",",dd[1],"],",sep="",end="",file=file1)
        if val > max: max = val
        index = index+inc
    print("[",int(index-inc),",",max+500,"],[0,",max+500,"]],convexity=1);",sep="",file=file1)

def loadBmp2():
    plotlist1 = collections.deque()
    plotlist2 = collections.deque()
    bmp = numpy.rot90(imageio.imread("./glasses2.bmp"))
    offset=0
    index = 0
    inc = int(3025/bmp.shape[0])
    mult = inc

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
        #pdb.set_trace()
        vala = whites[0][0]*mult
        valb = whites[-1][0]*mult
        if len(whites) > 2:
            valanext = whites[1][0]*mult
            valbnext = whites[-2][0]*mult
            for dd in bres((index, vala),(index+inc,valanext)):
                plotlist1.append((dd[0], dd[1])) 
            for dd in bres((index, valb),(index+inc,valbnext)):
                plotlist2.append((dd[0], dd[1]))
#                print("[",dd[0],",",dd[1],"],",sep="",end="",file=file1)
#            for jj in range(0, inc):
#                plotlist1.append((jj+index, jj+int(vala+((valanext-vala)/inc))))
#            for jj in range(0, inc):
#                plotlist2.append((jj+index, jj+int(valb+((valbnext-valb)/inc))))
        else:
            plotlist1.append((index, vala))
            plotlist2.append((index, valb))
        if vala > maxa: maxa = vala
        if valb > maxb: maxb = valb
        index = index+inc
    for xx in plotlist1:
        print("[",xx[0],",",xx[1],"],",sep="",end="", file=file2a)
    for xx in plotlist2:
        print("[",xx[0],",",xx[1],"],",sep="",end="", file=file2b)

    #print("[",int(index-inc),",",maxa+500,"],[0,",maxa+500,"]],convexity=1);",sep="",file=file2a)
    print("[",int(index-inc),",0],[0,0]],convexity=1);",sep="",file=file2a)
    print("[",int(index-inc)+500,",0],[",int(index-inc)+500,",1000],[0,1000]],convexity=1);",sep="",file=file2b)

    #print("],convexity=1);", sep="", file=file2a)
    #print("],convexity=1);", sep="", file=file2b)
    #print("[",int(index),",0],[",int(index)+10,",0]],convexity=1);",sep="")

loadBmp("./glasses1.bmp", "glasses1.dat")
loadBmp2()
