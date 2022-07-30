#!/usr/bin/env python3

import argparse
import numpy as np
import os
import pdb
from scipy.interpolate import interp1d
#x = np.linspace(0, 10, num=11, endpoint=True)
#y = np.cos(-x**2/9.0)
#y = [0, 1, 1, 2, 3, 5, 8, 13]
waypoints = np.array([0, 5, 10, 11, 7, 12, 40, 39])
#x = range(len(y))
#x0 = np.linspace(0, len(waypoints)-1, num=50, endpoint=True)
#f = interp1d(x, y)
#f2 = interp1d(x, y, kind='cubic')

def genscadfile(waypoints, length, height, varname, filename):
    pdb.set_trace()
    y0 = waypoints # * (height/waypoints.max())
    x0 = np.linspace(0, len(y0)-1, num=length, endpoint=True)
    interp = interp1d(range(len(y0)), y0, 'cubic')
    y1 = interp(x0)
    y1 = y1 * (height/y1.max())
#    y0 = list(interp(x0)
#    for x,y in enumerate(interp(x0)):
#        print(f'[{round(x)},{int(round(y))}]')
    scadfile = open(filename, 'wb')
    scadfile.write(f'{varname} = ['.encode())
    scadfile.write(','.join([f'[{round(x)},{int(round(y))}]' for x,y in enumerate(y1)]).encode())
    #scadfile.write(','.join([f'[{round(x)},{int(round(y))}]' for x,y in enumerate(interp(x0))]).encode())
    scadfile.write(f',[{len(x0)-1},0]];'.encode())

genscadfile(waypoints, 1000, 1000, 'curve', 'curve.dat')

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
