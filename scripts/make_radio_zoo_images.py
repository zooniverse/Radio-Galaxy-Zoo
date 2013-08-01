#!/usr/bin/env python

# code and notes on how to generate images for the Radio Zoo project
#
# written by Enno Middelberg in January 2012


# requires the following non-standard packages:
#
# scipy, asciitable, pyfits, kapteyn, numpy, matplotlib, PIL (Python
# Imaging Library)


# the Spitzer and radio image need to be on the same coordinate grid
# (same pixel size etc). The only way to make this work was to use
# Casapy. Here is how (adjust file names as necessary):

# radio=ia.fromfits(infile='Chris.StokesI.fits', outfile='Chris.StokesI')
# ch1=ia.fromfits(infile='ch1.fits', outfile='ch1')
#
# ia.open('ch1')
# mycs=ia.coordsys()
# myshape=ia.shape()
#
# ia.open('Chris.StokesI')
# radio_regridded=ia.regrid(outfile='Chris.StokesI_regridded', csys=mycs.torecord(), shape=myshape, overwrite=True, dropdeg=True)
#
# ia.open('Chris.StokesI_regridded')
# ia.tofits('Chris.StokesI_regridded.fits')


#
#
# PREAMBLE - adjust parameters as necessary
#
#

# an ascii table with the radio datal; ID, RA, Dec per line, separated
# by blanks; coordinates in degrees; one header line for column labels
# starting with '#'

# example:
# SID  ra_deg               dec_deg
#    S001 51.511604166666665   -28.78585
#    S002 51.5173              -27.949830555555554
#    S003 51.52368750000001    -27.792911111111106

# location of radio image, Spitzer image and radio input catalogue
radioimg = 'ELAIS20cm.I.SNR_regrid.fits'
ch1img = 'ch1_mosaic_upright.fits'
radiotable = 'input_ELAIS.dat'
# radioimg='CDFS20cm.I.SNR_regridded.fits'
# ch1img='ch1.fits'
# radiotable='input_CDFS.dat'

# names of the ID, ra and dec colums
IDcol = 'Src'
racol = 'ra_deg'
deccol = 'dec_deg'

# half-size of subimages to extract from input FITS files, in pixels
xdim = 150
ydim = 150

# desired dimension of output PNG images in pixels. Images are made
# square
outdim = 500.0

# number of radio image sigmas for lowest contour. This is also used
# to draw a blue transparent outline of radio sources
nsig = 3.0
# factor by which to increase contours
sigmult = 1.7320508075688772

# range of Spitzer image pixel values to display as heatmap, in units
# of image units
# reasonable values for CDFS
# vmin=0.02
# vmax=0.1
# and for ELAIS
# vmin=0.055
# vmax=0.15
# if log10 is taken before imshow, use the following settings
vmin = -1.3
vmax = -0.5

#
#
# END OF PREAMBLE - NO NEED TO EDIT BELOW
#
#


# import packages
import math as m
from scipy.special import erfinv
import asciitable as at
import pyfits as pf
from kapteyn import wcs
import numpy as n
import pylab as p
import Image
import sys
import os
import pprocess
import matplotlib

# this is a blue-only colormap, going from black to blue to white. z
# marks the point of pure blue
z = 0.5
cdict = {
  'blue': [(0.0, 0.0, 0.0),
  (z, 1.0, 1.0),
  (1.0, 1.0, 1.0)],
 'green': [(0.0, 0.0, 0.0),
  (z, 0.0, 0.0),
  (1.0, 1.0, 1.0)],
 'red': [(0.0, 0.0, 0.0),
  (z, 0.0, 0.0),
  (1.0, 1.0, 1.0)]}

my_cmap = matplotlib.colors.LinearSegmentedColormap('my_colormap', cdict, 256)

# convert desired output image size to inches, assuming 100 dpi
# resolution
outsize = outdim / 100.0

# divide by this to convert mad into sigma in radio image noise
# calculation
mad2sigma = m.sqrt(2) * erfinv(2 * 0.75 - 1)

# function to remove whitespace around an image


def trim_image(filename):
    img = Image.open(filename)
    imgpix = n.array(img)
    slice = n.where(imgpix[:,:, 0] == 255, 0, imgpix[:,:, 0])
    B = n.argwhere(slice)
    (ystart, xstart), (ystop, xstop) = B.min(0), B.max(0) + 1
    trimmed = imgpix[ystart:ystop, xstart:xstop,:]
    trimmedimg = Image.fromarray(trimmed)
    trimmedimg.save(filename)


# read radio source catalog
data = at.read(radiotable)
print '\nRead %i lines from radio catalogue at %s' % (len(data), radiotable)

# open the ch1 fits image
print 'Reading Spitzer image from file %s...' % ch1img
ch1 = pf.open(ch1img)
proj = wcs.Projection(ch1[0].header)
width, height = proj.naxis
ch1pix = n.flipud(ch1[0].data)
xmax = proj.naxis[0]
ymax = proj.naxis[1]
print 'Image dimensions are %ix%i pixels' % (xmax, ymax)

# open the radio image
print 'Reading radio image from file %s...' % radioimg
radio = pf.open(radioimg)
radiopix = n.flipud(radio[0].data)

# this array stores entries from 'data' which are suitable for image
# making
gooddata = n.recarray(shape=(0), dtype=data.dtype)

# test if all desired subimages can be extracted
for row in data:
    #
    # get data for current source
    ID = row[IDcol]
    print 'Testing if subimage for source %s can be extracted...' % ID
    xpix = round(proj.topixel((row[racol], row[deccol]))[0])
    ypix = round(proj.topixel((row[racol], row[deccol]))[1])
    #
    # test if both images have valid data at source position
    if n.isnan(radiopix[ypix, xpix]):
        print "Radio image at position of %s is nan, remove it from input source list" % str(ID)
        continue
    # test if sub-image extends beyond input images
    if height - ypix - ydim < 0 or height - ypix + ydim > ymax or xpix - xdim < 0 or xpix + xdim > xmax:
        print '''
Desired subimage for source %s with corners at (%i, %i), (%i, %i)
extends beyond input image - remove this source from input catalogue
or reduce size of subimage. Exiting.''' % (ID, height - ypix - ydim, height - ypix + ydim, xpix - xdim, xpix + xdim)
        continue
    # if all tests passed, add line to array of good sources for later
    # image processing
    else:
        gooddata.resize(gooddata.shape[0] + 1)
        gooddata[-1] = row

at.write(gooddata, output='%s_good.csv' % radiotable, delimiter=',')

# some nice examples in ELAIS:
examples = ['S829.2', 'S1189', 'S1081', 'S829', 'S923', 'S926']
examples = ['S53']

# loop over sources in input catalog


def make_images(row):
    #
    # get data for current source
    ID = row[IDcol]
    print '\n\nProcessing source %s...' % ID
    xpix = round(proj.topixel((row[racol], row[deccol]))[0])
    ypix = round(proj.topixel((row[racol], row[deccol]))[1])
    #
    # write FITS images
    os.system('/opt/Montage_v3.3/bin/mSubimage %s %s_radio.fits %f %f 0.05' %
              (radioimg, str(ID), row[racol], row[deccol]))
    os.system('/opt/Montage_v3.3/bin/mSubimage %s %s_ir.fits %f %f 0.05' %
              (ch1img, str(ID), row[racol], row[deccol]))
    #
    # extract subimage from Spitzer image and replace NaN with some
    # value which is not going make these regions black or white,
    # which would make the image trimming fall over
    ch1subpix = ch1pix[
        height - ypix - ydim:height - ypix + ydim, xpix - xdim:xpix + xdim]
    ch1subpix[n.isnan(ch1subpix)] = (vmin + vmax) / 2
    #
    # extract radio data and derive some statistics to set reasonable
    # contours
    imgdata = radiopix[
        height - ypix - ydim:height - ypix + ydim, xpix - xdim:xpix + xdim]
    # the following is needed when the input radio image is not a SNR image
    med = n.median(imgdata)
    mad = n.median(n.abs(imgdata - med))
    sigma = mad / mad2sigma
    print 'Found sigma of %.2e' % sigma
    #
    # if the input image is a SNR image, set sigma to one
    sigma = 1.0
    #
    # make heat map (+ radio contours)
    print 'Producing heat map (+contours) from ch1 image...'
    fig = p.figure(figsize=(outsize, outsize), dpi=100)
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_axis_off()
    p.imshow(n.log10(ch1subpix), cmap='gist_heat', vmin=vmin, vmax=vmax)
    #p.savefig('%s_heatmap.png' % ID, bbox_inches='tight')
    #trim_image('%s_heatmap.png' % ID)
    p.contour(imgdata, colors='#BBBBBB',
              levels=[nsig * sigma * sigmult ** i for i in range(15)])
    p.savefig('%s_heatmap+contours.png' % ID)  # , bbox_inches='tight')
    #trim_image('%s_heatmap+contours.png' % ID)
    p.clf()
    #
    # make heat map + blue radio overlay
    # print 'Producing heat map + radio...'
    #fig=p.figure(figsize=(outsize,outsize), dpi=100)
    # ax=fig.add_axes([0,0,1,1])
    # ax.set_axis_off()
    #p.imshow(n.log10(ch1subpix), cmap='gist_heat', vmin=vmin, vmax=vmax)
    #p.contourf(imgdata, alpha=0.5, colors='blue', levels=[nsig*sigma, 1.0e10])
    # for N in [5*m.sqrt(2.0)**x for x in range(50)]:
    #    p.contourf(imgdata, alpha=0.1, colors='blue', levels=[sigma*N, 1e10])
    #p.savefig('%s_heatmap+radio.png' % ID, bbox_inches='tight')
    #trim_image('%s_heatmap+radio.png' % ID)
    # p.clf()
    #
    # make heatmap + grey radio overlay
    # print 'Producing heat map + grey radio...'
    # fig=p.figure(figsize=(outsize,outsize), dpi=100)
    # ax=fig.add_axes([0,0,1,1])
    # ax.set_axis_off()
    # p.imshow(n.log10(ch1subpix), cmap='gist_heat', vmin=vmin, vmax=vmax)
    # maxcont=m.ceil(m.log10(imgdata.max()/3.0)/m.log10(1.41))
    # p.contourf(imgdata, levels=[3.0*1.41**N for N in range(0, maxcont+1)], cmap=p.cm.bone)
    # p.savefig('%s_heatmap+grey_radio.png' % ID, bbox_inches='tight')
    # trim_image('%s_heatmap+grey_radio.png' % ID)
    # p.clf()
    #
    # make radio image
    print 'Producing radio-only image...'
    fig = p.figure(figsize=(outsize, outsize), dpi=100)
    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_axis_off()
    p.imshow(imgdata, cmap=my_cmap, vmin=-1, vmax=20.0)
    p.savefig('%s_radio.png' % ID)  # , bbox_inches='tight')
    #trim_image('%s_radio.png' % ID)

    p.close('all')


# execute image generation in parallel
nproc = 6
#data_short=data[n.in1d(data[IDcol], examples)]
print gooddata
arglist = [x for x in gooddata]

# this is something like a "parallel map" thing
results = pprocess.pmap(make_images, arglist, limit=nproc)

# don't delete this - if results from the pmap call are not requested,
# execution will terminate after 'limit' number of processes
for x in results:
    print x
