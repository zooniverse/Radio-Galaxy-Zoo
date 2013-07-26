
import os
import sys
import glob

import numpy as np
import matplotlib.pyplot as plt
from astropy.io import fits
import Image

def make_png(f):
  name = os.path.splitext(f)[0]
  
  # Get flux
  data = fits.getdata(f)
  
  # Stretch and scale images
  # midpoint = 0.0625
  # data = np.log10(data / midpoint + 1.) / np.log10(1. / midpoint + 1.)
  midpoint = -0.033
  data = np.arcsinh(data / midpoint) / np.arcsinh(1. / midpoint)
  
  minimum = np.nanmin(data)
  maximum = np.nanmax(data)
  data = (255 * (data - minimum) / (maximum - minimum)).astype('uint8')
  
  cmap = plt.get_cmap('gist_heat')
  data = (255 * cmap(data)).astype('uint8')
  im = Image.fromarray(data)
  im.save("%s.png" % (name))


if __name__ == '__main__':
  if len(sys.argv) < 2:
    sys.exit()
  
  directory = sys.argv[1]
  os.chdir(directory)
  for f in glob.glob("*ir.fits"):
    make_png(f)