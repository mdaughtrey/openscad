#!/usr/bin/env python3

import argparse
import numpy as np
import os
import pdb
from scipy.interpolate import interp1d
#x = np.linspace(0, 10, num=11, endpoint=True)
#y = np.cos(-x**2/9.0)
#y = [0, 1, 1, 2, 3, 5, 8, 13]

inner = np.array([ [148,883], [198,882], [248,886], [298,885], [348,882], [398,882], [448,880], [498,878], [548,878], [598,876], [648,875], [698,874], [748,874], [798,873], [848,874], [898,874], [948,874], [998,875], [1048,876], [1098,878], [1148,881], [1198,880], [1248,883], [1298,880], [1348,879], [1398,875], [1448,855], [1498,815], [1548,746]],dtype=float)

outer = np.array([ [287,546], [337,587], [387,629], [437,647], [487,660], [537,657], [587,655], [637,647], [687,640], [737,637], [787,634], [837,630], [887,629], [937,625], [987,625], [1037,625], [1087,624], [1137,622], [1187,620], [1237,619], [1287,618], [1337,620], [1387,619], [1437,620], [1487,618], [1537,619], [1587,619]],dtype=float) 

def process(points, varname):
    w0 = points[:,0]
    w1 = points[:,1]
    oneinch=0.210
    pdb.set_trace()
    w0 -= np.min(w0)
    w1 -= np.min(w1)
    w1 = np.max(w1)-w1
    w0 = np.floor(w0/oneinch)
    w1 = np.floor(w1/oneinch)
    genscadfile(w1, np.max(w0)-np.min(w0), np.max(w1), varname)

#waypoints[:,0] /= oneinch
#waypoints[:,1] /= oneinch
#x = range(len(y))
#x0 = np.linspace(0, len(waypoints)-1, num=50, endpoint=True)
#f = interp1d(x, y)
#f2 = interp1d(x, y, kind='cubic')

def genscadfile(waypoints, length, height, varname):
    y0 = waypoints # * (height/waypoints.max())
    x0 = np.linspace(0, len(y0)-1, num=length, endpoint=True)
    interp = interp1d(range(len(y0)), y0, 'cubic')
    y1 = interp(x0)
    y1 = y1 * (height/y1.max())
#    y0 = list(interp(x0)
#    for x,y in enumerate(interp(x0)):
#        print(f'[{round(x)},{int(round(y))}]')
    scadfile = open(varname + '.dat', 'wb')
    scadfile.write(f'{varname} = ['.encode())
    scadfile.write(','.join([f'[{round(x)},{int(round(y))}]' for x,y in enumerate(y1)]).encode())
    #scadfile.write(','.join([f'[{round(x)},{int(round(y))}]' for x,y in enumerate(interp(x0))]).encode())
    scadfile.write(f',[{len(x0)-1},0]];'.encode())
    scadfile.write(b'];')
    print('{} max is {}, length is {}'.format(varname, np.max(y1), np.max(x0)))

process(inner, 'inner')
process(outer, 'outer')


#xnew = np.linspace(0, 10, num=41, endpoint=True)
#import matplotlib.pyplot as plt
#plt.plot(x, y, 'o', x, f(y), '-', x, f2(y), '--')
#plt.plot(x, y, 'o', x0, f(x0), '-', x0, f2(x0), '--')
#plt.legend(['data', 'linear', 'cubic'], loc='best')
#plt.show()

#from scipy.interpolate import interp1d
#x = np.linspace(0, 10, num=11, endpoint=True)
#y = np.cos(-x**2/9.0)
#f = interp1d(x, y)
#f2 = interp1d(x, y, kind='cubic')
#xnew = np.linspace(0, 10, num=41, endpoint=True)
#import matplotlib.pyplot as plt
#plt.plot(x, y, 'o', xnew, f(xnew), '-', xnew, f2(xnew), '--')
#plt.legend(['data', 'linear', 'cubic'], loc='best')
#plt.show()
