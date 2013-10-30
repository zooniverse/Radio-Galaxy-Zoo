import os
import sys
import glob
from astropy.io import fits


def clean(path):
  """Removes unnecessary HISTORY keyword from FITS file"""
  f = fits.open(path)
  header = f[0].header
  del header["HISTORY"]
  out = fits.PrimaryHDU(header = header, data = f[0].data)
  out.writeto(path, clobber=True)


if __name__ == '__main__':
  
  if len(sys.argv) < 2:
    print "Usage: python clean_fits.py [directory]"
    sys.exit()
  
  directory = sys.argv[1]
  
  os.chdir(directory)
  for f in glob.glob("*.fits"):
    clean(f)