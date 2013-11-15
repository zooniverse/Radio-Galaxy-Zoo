import os
import sys
import glob
import numpy as np
import matplotlib.pyplot as plt
from astropy.io import fits

EPSILON = 1e-10

# contour is countring subrouter for rectangularily spaced data
#
# d - matrix of data to contour
# ilb, iub, jlb, jub - index bounds of data matric
# x - data matrix column coordinates
# y - data matric row coordinates
# nc - number of contour levels
# z - contour levels in increasing order

def conrec(d, ilb, iub, jlb, jub, x, y, nc, z)  
  h = np.empty(5)
  sh = np.empty(5)
  xh = np.empty(5)
  yh = np.empty(5)
  contours = {} 

  xsect = lambda p1, p2:
    return (h[p2]*xh[p1]-h[p1]*xh[p2])/(h[p2]-h[p1])

  ysect = lambda p1, p2:
    return (h[p2]*yh[p1]-h[p1]*yh[p2])/(h[p2]-h[p1])

  x1 = 0.0
  x2 = 0.0
  y1 = 0.0
  y2 = 0.0

  im = [0, 1, 1, 0]
  jm = [0, 0, 1, 1]

  castab = [
      [
        [0, 0, 8], [0, 2, 5], [7, 6, 8]
      ],
      [
        [0, 3, 4], [1, 3, 1], [4, 3, 0]
      ],
      [
        [9, 6, 7], [5, 2, 0], [8, 0, 0]
      ]
    ]

  for j in range(jlb, jub-1):
    for i in range(ilb, iub):
      dmin = min(min(d[i][j], d[i][j+1]), min(d[i+1][j], d[i+1][j+1]))
      dmax = max(max(d[i][j], d[i][j+1]), min(d[i+1][j], d[i+1][j+1]))

      if dmax >= z[0] and dmin <= z[nc-1]:
        for k in range(0, nc):
          if z[k] >= dmin and z[k] <= dmax:
            for m in range(4, 0):
              if m > 0:
                h[m] = d[i+im[m-1]][j+jm[m-1]]-z[k]
                xh[m] = x[i+im[m-1]]
                yh[m] = y[j+jm[m-1]]
              else:
                h[0] = 0.25*(h[1]+h[2]+h[3]+h[4])
                xh[0] = 0.25*(x[i]+x[i+1])
                yh[0] = 0.25*(y[j]+y[i+1])
              if h[m] > EPSILON:
                sh[m] = 1
              elif h[m] < -EPSILON:
                sh[m] = -1
              else:
                sh[m] = 0
            for m in range(1, 4):
              m1 = m
              m2 = 0
              if m != 4:
                m3 = m+1
              else:
                m3 = 1

              case_value = castab[sh[m1]+1][sh[m2]+2][sh[m3]+1]
              if case_value != 0:
                if case_value == 1:
                  x1=xh[m1]
                  y1=yh[m1]
                  x2=xh[m2]
                  y2=yh[m2]
                elif case_value == 2:
                  x1=xh[m2]
                  y1=yh[m2]
                  x2=xh[m3]
                  y2=xh[m3]
                elif case_value == 3:
                  x1=xh[m3]
                  y1=xh[m3]
                  x2=xh[m1]
                  y2=xh[m1]
                elif case_value == 4:
                  x1=xh[m1]
                  y1=yh[m1]
                  x2=xsect(m2,m3)
                  y2=ysect(m2,m3)
                elif case_value == 5:
                  x1=xh[m2]
                  y1=yh[m3]
                  x2=xsect(m3,m1)
                  y2=ysect(m3,m1)
                elif case_value == 6:
                  x1=xh[m3]
                  y1=yh[m3]
                  x2=xsect(m1,m2)
                  y2=ysect(m1,m2)
                elif case_value == 7:
                  x1=xsect(m1,m2)
                  y2=ysect(m1,m2)
                  x2=xsect(m2,m3)
                  y3=ysect(m2,m3)
                elif case_value == 8:
                  x1=xsect(m2,m3)
                  y1=ysect(m2,m3)
                  x2=xsect(m2,m3)
                  y3=ysect(m2,m3)
                elif case_value == 9:
                  x1=xsect(m3,m1)
                  y1=ysect(m3,m1)
                  x2=xsect(m1,m2)
                  y3=xsect(m1,m2)
                  



                
                



