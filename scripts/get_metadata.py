
# Get more metadata about these fields from CDS's TAP service

import os
import sys
import json
import urllib

import numpy as np

from astropy import wcs
from astropy.io import fits
from astropy.io import votable

metadata = {}

QUERY_FIRST = """
SELECT TOP 100 "VIII/90/first12".recno,  "VIII/90/first12".FIRST,  "VIII/90/first12".RAJ2000,  "VIII/90/first12".DEJ2000,  "VIII/90/first12"."p(S)",  "VIII/90/first12".Fpeak,  "VIII/90/first12".Fint, 
"VIII/90/first12".Rms,  "VIII/90/first12".MajAxis,  "VIII/90/first12".MinAxis,  "VIII/90/first12".PA,  "VIII/90/first12".N1,  "VIII/90/first12".c1,  "VIII/90/first12".N2
FROM "VIII/90/first12"
WHERE 1=CONTAINS(POINT('ICRS',"VIII/90/first12".RAJ2000,"VIII/90/first12".DEJ2000), BOX('ICRS', 210.0, 54.9, 0.01., 0.01.))"
"""


def get_metadata_from_tap(f, src):
  tap_endpoint = "http://tapvizier.u-strasbg.fr/TAPVizieR/tap/sync"
  
  hdulist = fits.open(f)
  w = wcs.WCS(hdulist[0].header)
  
  width, height = hdulist[0].shape
  half_width = width / 2
  half_height = height / 2
  
  x_fov = np.abs(w.wcs_pix2world([[0, half_height]], 0)[0][0] - w.wcs_pix2world([[width, half_height]], 0)[0][0])
  y_fov = np.abs(w.wcs_pix2world([[half_width, 0]], 0)[0][1] - w.wcs_pix2world([[half_width, height]], 0)[0][1])
  
  center = w.wcs_pix2world([[half_width, half_height]], 0)[0]
  
  params = {
    'REQUEST': 'doQuery',
    'LANG': 'ADQL',
    # 'QUERY': "SELECT TOP 100 RAJ2000, DEJ2000, type, cz, e_cz FROM \"J/ApJS/199/26/table3\" WHERE 1=CONTAINS(POINT('ICRS',\"J/ApJS/199/26/table3\".RAJ2000,\"J/ApJS/199/26/table3\".DEJ2000), BOX('ICRS', %.6f, %.6f, %.6f, %.6f))" % (center[0], center[1], 0.5 * x_fov, 0.5 * y_fov)
    
    'QUERY': "SELECT Cntr, raj2000, dej2000, Jmag, Hmag, Kmag, Bmag, Rmag FROM \"II/246/out\" WHERE 1=CONTAINS(POINT('ICRS', raj2000, dej2000), BOX('ICRS', %.6f, %.6f, %.6f, %.6f))" % (center[0], center[1], 0.5 * x_fov, 0.5 * y_fov)
  }
  
  
  f = urllib.urlopen(tap_endpoint, urllib.urlencode(params))
  vot = votable.parse(f)
  for resource in vot.resources:
    for table in resource.tables:
      cntrs = table.array['Cntr']
      ras  = table.array['RAJ2000']
      decs = table.array['DEJ2000']
      jmags = table.array['Jmag']
      hmags = table.array['Hmag']
      kmags = table.array['Kmag']
      bmags = table.array['Bmag']
      rmags = table.array['Rmag']
      
      if len(ras) > 0:
        metadata[src] = []
      
      for index, ra in enumerate(ras):
        obj = {}
        
        dec = decs[index]
        pixel = w.wcs_world2pix([[ra, dec]], 0)[0]
        
        obj['cntr'] = str(cntrs[index])
        obj['ra'] = str(ra)
        obj['dec'] = str(dec)
        obj['x'] = str(pixel[0])
        obj['y'] = str(pixel[1])
        obj['Jmag'] = str(jmags[index])
        obj['Hmag'] = str(hmags[index])
        obj['Kmag'] = str(kmags[index])
        obj['Bmag'] = str(bmags[index])
        obj['Rmag'] = str(rmags[index])
        
        metadata[src].append(obj)

if __name__ == '__main__':
  
  # Get list of files
  data_dir = os.path.join('..', 'data-import', 'rgz_fits')
  files = os.listdir(data_dir)
  
  for f in files:
    path = os.path.join(data_dir, f)
    print path
    get_metadata_from_tap(path, f.split("_ir.fits")[0])
  
  out = open('2MASS-metadata.json', 'w')
  out.write(json.dumps(metadata))
  out.close()
