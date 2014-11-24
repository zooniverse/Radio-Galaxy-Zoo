# Kyle Willett - willett@physics.umn.edu
#
# Make all 2x2 radio contours, heatmap+contour images for the ATLAS sample.

from PIL import Image
from astropy.io import fits
from matplotlib import pyplot as plt
from matplotlib.path import Path
from scipy.special import erfinv

import json
import make_contours
import matplotlib.patches as patches
import numpy as np
import os,glob

# Local path name - likely needs to be changed
imgdir = '/Volumes/3TB/rgz/raw_images/ATLAS/2x2'

filenames = glob.glob('%s/*radio.fits' % imgdir)
galnames = [os.path.basename(s).split('_')[0] for s in filenames]

interval = np.sqrt(4)

xsize_pix = 500
ysize_pix = 500

for galname in galnames:
    
    # Load the radio data
    radio_fits = '%s/%s_radio.fits' % (imgdir,galname)
    with fits.open(radio_fits) as f:
        imgdata = f[0].data
    
    # convert median absolute difference into sigma in radio image noise calculation
    mad2sigma=np.sqrt(2)*erfinv(2*0.75-1)
    
    # compute sigma for the contour calculation
    med=np.median(imgdata)
    mad=np.median(np.abs(imgdata-med))
    sigma=mad/mad2sigma
    
    # Create contours
    cs = make_contours.contour(radio_fits, sigma * 3, interval)
    cs['contours'] = map(make_contours.points_to_dict, cs['contours'])

    # Write contours to JSON file
    with open('%s/%s_contours.json' % (imgdir,galname),'w') as fobj:
        json.dump(cs,fobj)

    # Load the heatmap data
    
    im_standard = Image.open('%s/%s_heatmap.png' % (imgdir,galname))

    sf_x = float(xsize_pix)/cs['width']
    sf_y = float(ysize_pix)/cs['height']
    
    verts_all = []
    codes_all = []
    components = cs['contours']

    # Scale contours to heatmap size
    
    for comp in components:
    
        for idx,level in enumerate(comp):
            verts = [((p['x'])*sf_x,(p['y'])*sf_y) for p in level['arr']]
            
            codes = np.ones(len(verts),int) * Path.LINETO
            codes[0] = Path.MOVETO
        
            verts_all.extend(verts)
            codes_all.extend(codes)
    
    # Create matplotlib path for contours
    path = Path(verts_all, codes_all)
    patch_contour = patches.PathPatch(path, facecolor = 'none', edgecolor='limegreen', lw=1)

    # Set up plot (no axis or whitespace)
    # http://stackoverflow.com/questions/9295026/matplotlib-plots-removing-axis-legends-and-white-spaces

    my_dpi = 100

    fig = plt.figure()
    fig.set_size_inches(xsize_pix/my_dpi,ysize_pix/my_dpi)
    ax = plt.Axes(fig, [0., 0., 1., 1.])
    ax.set_axis_off()
    fig.add_axes(ax)

    ax.set_xlim([0, xsize_pix])
    ax.set_ylim([ysize_pix, 0])
    ax.set_aspect('equal')
    ax.imshow(im_standard,origin='upper')
    ax.add_patch(patch_contour)
    
    # Save hard copy of the figure
    plt.savefig('%s/%s_heatmap+contours.png' % (imgdir,galname),dpi=my_dpi)

    plt.close()

