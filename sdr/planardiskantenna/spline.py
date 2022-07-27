#!/usr/bin/env python3

import numpy as np
import pdb
from scipy.interpolate import interp1d
#x = np.linspace(0, 10, num=11, endpoint=True)
#y = np.cos(-x**2/9.0)
#y = [0, 1, 1, 2, 3, 5, 8, 13]
y = [0, 5, 10, 11, 7, 12, 40, 39]
x = range(len(y))
x0 = np.linspace(0, len(y)-1, num=50, endpoint=True)
f = interp1d(x, y)
f2 = interp1d(x, y, kind='cubic')
#xnew = np.linspace(0, 10, num=41, endpoint=True)
import matplotlib.pyplot as plt
#plt.plot(x, y, 'o', x, f(y), '-', x, f2(y), '--')
plt.plot(x, y, 'o', x0, f(x0), '-', x0, f2(x0), '--')
plt.legend(['data', 'linear', 'cubic'], loc='best')
plt.show()

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
