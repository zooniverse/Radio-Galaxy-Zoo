'''
In Enno Middelberg's script, finding the rms is accomplished by calculating the Median
Absolute Difference of an image and converting it to the standard
deviation by dividing by a certain factor. Using the MAD is much more
robust against the presence of strong sources than simply calculating
the standard deviation directly.
'''

from scipy.special import erfinv
import numpy as np
from astropy.io import fits
import make_contours
from PIL import Image
from matplotlib import pyplot as plt
from matplotlib.pyplot import cm
from matplotlib.path import Path
import matplotlib.patches as patches
import os,glob

imgdir = '/Volumes/3TB/rgz/raw_images/ATLAS/2x2'
plot_dir = '/Users/willettk/Astronomy/Research/GalaxyZoo/radiogalaxyzoo/ATLAS/comparing_intervals'

galname = 'CI0001C1'

filenames = glob.glob('%s/*radio.fits' % imgdir)[:100]
galnames = [os.path.basename(s).split('_')[0] for s in filenames]

intervals = [np.sqrt(n) for n in (2,3,4,5,6)]

for galname in galnames:
    
    radio_fits = '%s/%s_radio.fits' % (imgdir,galname)
    with fits.open(radio_fits) as f:
        imgdata = f[0].data
    
    # divide by this to convert mad into sigma in radio image noise
    # calculation
    mad2sigma=np.sqrt(2)*erfinv(2*0.75-1)
    
    # the following is needed to derive some statistics when the input radio image is not a SNR image
    med=np.median(imgdata)
    mad=np.median(np.abs(imgdata-med))
    sigma=mad/mad2sigma
    
    # Plot the infrared results
    
    fig,axarr = plt.subplots(1,len(intervals),figsize=(15,4))
    #fig.clf()
    
    im_standard = Image.open('%s/%s_heatmap.png' % (imgdir,galname))

    for index,(ax,interval) in enumerate(zip(axarr,intervals)):
        cs = make_contours.contour(radio_fits, sigma * 3, interval)
        cs['contours'] = map(make_contours.points_to_dict, cs['contours'])

        sf_x = 500./cs['width']
        sf_y = 500./cs['height']
        
        verts_all = []
        codes_all = []
        components = cs['contours']
        
        for comp in components:
        
            for idx,level in enumerate(comp):
                verts = [((p['x'])*sf_x,(p['y']-1)*sf_y) for p in level['arr']]
                
                codes = np.ones(len(verts),int) * Path.LINETO
                codes[0] = Path.MOVETO
            
                verts_all.extend(verts)
                codes_all.extend(codes)
        
        path = Path(verts_all, codes_all)
        patch_black = patches.PathPatch(path, facecolor = 'none', edgecolor='limegreen', lw=1)
        
        # Display IR and radio images
        
        '''
        im_standard = Image.open('%s/%s_heatmap.png' % (imgdir,galname))
        ax1.imshow(im_standard,origin='upper')
        ax1.set_title(galname)
        
        im_radio = Image.open('%s/%s_heatmap+contours.png' % (imgdir,galname))
        ax2.imshow(im_radio,origin='upper')
        ax2.set_title('Original levels')
        '''
        
        ax.set_xlim([0, 500])
        ax.set_ylim([500, 0])
        ax.set_title('%s - sqrt(%i)' % (galname,round(interval**2)))
        ax.set_aspect('equal')
        ax.imshow(im_standard,origin='upper')
        ax.add_patch(patch_black)
        ax.yaxis.tick_right()
        
        if index == 0:
            ax.get_xaxis().set_ticks([0,100,200,300,400])
        elif index == len(intervals)-1:
            ax.get_xaxis().set_ticks([0,100,200,300,400])
        else:
            ax.get_xaxis().set_ticks([0,100,200,300,400])
            ax.get_yaxis().set_ticklabels(['','','','',''])
    
    plt.subplots_adjust(wspace=0.02)
    
    #plt.show()
      
    # Save hard copy of the figure
    fig.savefig('%s/%s_heatmap+contours_new.png' % (plot_dir,galname))

    plt.close()

# Make webpage

with open('/Users/willettk/Astronomy/Research/GalaxyZoo/radiogalaxyzoo/atlas_contours.html','w') as f:
    for galname in galnames:
        # Remove obvious stars
            # Regular
            f.write('<IMG SRC="ATLAS/comparing_intervals/%s_heatmap+contours_new.png">' % galname)

