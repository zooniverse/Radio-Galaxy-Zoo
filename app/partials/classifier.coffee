module.exports = """
<div class="example-container" data-ng-controller="ClassifierCtrl">
  <div data-ng-click="activateGuide()" class="row example-selection" ng-class="{'active': getGuide()}">
    Spotter's Guide
  </div>
  <div class="examples row" ng-class="{'active': getGuide()}">
    <span class="col-xs-4 example" ng-class="{'active': getExample()=='compact'}" data-type="compact">Compact</span>
    <span class="col-xs-4 example" ng-class="{'active': getExample()=='extended'}" data-type="extended">Extended</span>          
    <span class="col-xs-4 example" ng-class="{'active': getExample()=='multiple'}" data-type="multiple">Multiple</span>

    <div class="row example-box">
      <div ng-switch on="getExample()">
        <div ng-switch-when="compact">
          <div class="row">
            <img src="http://i.imgur.com/JwLkoWf.png" / />
            <p>One roundish blob with a galaxy in the middle.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/5I6c3X5.png" />
            <p>The galaxy is at the center of the roundish radio source.</p>
          </div>

          <div class="row">
            <img src="http://i.imgur.com/CEkerlE.png" />
            <p>One roundish blob with a galaxy in the middle.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/NOsdJJ1.png" />
            <p>The galaxy is at the center of the roundish radio source.</p>
          </div>

          <div class="row">
            <img src="http://i.imgur.com/lLTWokz.png" />
            <p>One roundish blob with a galaxy in the middle.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/HOVImG.png" />
            <p>The galaxy is at the center of the roundish radio source.</p>
          </div>
        </div>

        <div ng-switch-when="extended">
          <div class="row">
            <img src="http://i.imgur.com/8MhmWG9.png" />
            <p>3 components aligned and "connected" each blobs extended towards one another.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/4DC1WkO.png" />
            <p><b>Green line:</b> The galaxy is at the center of the middle blob and the other 2 blobs extend towards it.</p>
            <p><b>Pink line:</b> Although the galaxy is at its center, because the right blob extends toward the middle blob, it is not a separate source.</p>
          </div>

          <div class="row">
            <img src="http://i.imgur.com/SBkzZMG.png" />
            <p>3 components aligned and "connected" each blobs extended towards one another.</p>
            <p>Obvious galaxy in the middle of the central component.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/rcRecZO.png" />
            <p><b>Green line:</b> The galaxy is at the center of the middle blob, and the other 2 blobs extend towards it.</p>
            <p><b>Pink line:</b> The galaxy is too offset from the center of the radio source.</p>
          </div>

          <div class="row">
            <img src="http://i.imgur.com/V4TpnUN.png" />
            <p>2 components aligned and "connected", each blobs extending towards one another.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/IqV2BLN.png" />
            <p><b>Green line:</b> The galaxy is located between 2 blobs and is roughly at the center of the source.</p>
            <p><b>Pink lines:</b> These galaxies, although "covered" by the radio source, are too much on the side of the whole source.</p>
          </div>

          <div class="row">
            <img src="http://i.imgur.com/53n1OGX.png" />
            <p>The source is 8-shaped, and neither blob has a galaxy in its center. This indicates that it has two lobes that we can not see the details of.</p>
            <p>The galaxy is between the two lobes, near the center of the radio source.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/ZitAkd0.png" />
            <p>The galaxy is at the center of the roundish radio source.</p>
          </div>

          <div class="row">
            <img src="http://i.imgur.com/aiba51W.png" />
            <p>The source is somewhat 8-shaped, and neither blob has a galaxy in its center. This indicates that it has 2 lobes that we can not see the details of.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/BimKgCB.png" />
            <p>The galaxy is between the two lobes, near the center of the radio source.</p>
          </div>

          <div class="row">
            <img src="http://i.imgur.com/uhI3xNz.png" />
            <p>The blobs are weak, but still extend towards each other.</p>
            <p>These two small blobs are separate from the big source and they both have a galaxy at the center - they are different sources.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/vbs1A2V.png" />
            <p><b>Green line:</b> The galaxy is between the two lobes, towards the center of the radio source.</p>
            <p><b>Pink line:</b> This galaxy is slightly too offset from the center of the radio source.</p>
          </div>

          <div class="row">
            <img src="http://i.imgur.com/0GZawBb.png" />
            <p><b>Top line:</b> 2 components "connected" to each other.</p>
            <p><b>Bottom line:</b> Blobs aligned with the 2 components - probably a faded lobe.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/fy8LHdK.png" />
            <p><b>Green line:</b> The galaxy is at the center of the middle blob, and the other two blobs extend towards it.</p>
            <p><b>Pink line:</b> This galaxy is too much on the edge of the right blob for it to be a separate source.</p>
          </div>

          <div class="row">
            <img src="http://i.imgur.com/Ij5ClIS.png" />
            <p>2 components "connected" to each other with the lobes extending towards one another.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/EWcIUe2.png" />
            <p><b>Green line:</b> The galaxy is at the center of the roundish blob.</p>
            <p><b>Middle Pink line:</b> Although at the center of the radio source, this galaxy is less likely to be the host than the one at the center of the blob above.</p>
            <p><b>Bottom Pink line:</b> This galaxy is too much on the edge of the radio source.</p>
          </div>
        </div>

        <div ng-switch-when="multiple">
          <div class="row">
            <img src="http://i.imgur.com/T0qP6Vo.png" />
            <p><b>Right box:</b> The top blob has a galaxy at its center and the bottom blob extends towards it.</p>
            <p><b>Left box:</b> The two blobs do not have galaxies at their center and are extended towards each other.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/MuGZdqP.png" />
            <p><b>1st line:</b> The galaxy is at the center of the roundish radio source.</p>
            <p><b>2nd line:</b> This galaxy is too much at the edge of the radio source.</p>
            <p><b>3rd line:</b> The galaxy is between the two lobes, towards the center of the radio source.</p>
            <p><b>4th line:</b> The galaxy is too offset from the center of the radio source.</p>
          </div>

          <div class="row">
            <img src="http://i.imgur.com/uhMPY8Y.png" />
            <p><b>Left:</b> The blobs on the left are "connected" but each one of them has a galaxy in the middle - they are separate sources.</p>
            <p><b>Right:</b> The blob on the right also has its own galaxy in the middle.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/eruqmTl.png" />
            <p>In each case, the galaxy is at the center of the roundish radio source.</p>
          </div>

          <div class="row">
            <img src="http://i.imgur.com/6OBTkhC.png" />
            <p>The blobs are "connected" and extended towards each other.</p>
            <p><b>Marked:</b> These blobs, although inside the source, have galaxy at the center - they are probably sources in the background.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/pmPhCkR.png" />
            <p><b>Green line:</b> This galaxy is at the center of the whole radio source, with one large lobe on each side.</p>
            <p><b>Pink lines:</b> These galaxies, altough in the large source, are at the center of their own blobs. They are most probably background galaxies.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="classifier row" data-ng-controller="ClassifierCtrl">

  <div class="workflow col-xs-6 col-centered">
    <div class="viewport col-centered">
      <img data-ng-src="{{ getRadioSource() }}" />
      <img class="infrared" data-ng-src="{{ getInfraredSource() }}" />

      <div id="svg-contours" class='contours marking step-{{getStep()}}' ng-class="{'fade-contour': !getShowContours()}">
        <svg xmlns="http://www.w3.org/2000/svg" class="svg-contours"></svg>
      </div>
      <span class="toggle-contours btn-primary {{getShowContours() ? '' : 'nocontours'}}" title="{{getShowContours() ? 'Hide' : 'Show'}} Contours"></span>
      <span class="tutorial btn-primary" data-ng-click="onTutorial()" title="Tutorial"></span>
    </div>

    <div class="row controls">
      <div class="image-slider col-xs-7">
        <p class="band" data-band="radio">Radio</p>
        <input class='image-opacity' type="range" min="0" max="1" step="0.01" value="0" />
        <p class="band" data-band="infrared">IR</p>
      </div>
    </div>


    <div class='row instruction'>
      <div ng-switch on="getStep()">
        <div ng-switch-when="0">
          <p>Click on any radio contour or pair of jets</p>
        </div>

        <div ng-switch-when="1">
          <p>Click the associated infrared source(s)</p>
        </div>

        <div ng-switch-when="2">
          <p>Are there any more sources?</p>
        </div>

        <div ng-switch-when="3">
          <p>Great work: you helped science!</p>
        </div>
      </div>
    </div>

    <div class='buttons row step-{{getStep()}}'>
      <div ng-switch on="getStep()">
        <div ng-switch-when="0" class="col-xs-12">
          <button type="button" class="btn btn-primary back" data-ng-click="onCancel()" ng-disabled="getContourCount()">Cancel</button>
          <button type="button" class="btn btn-primary no-contours" data-ng-click="onFinish()" ng-disabled="!getContourCount()">No Contours</button>
        </div>
        <div ng-switch-when="1" class="col-xs-12">
          <button type="button" class="btn btn-primary back" data-ng-click="onCancel()">Cancel</button>
          <button type="button" class="btn btn-default col-xs-offset-3 no-infrared" data-ng-click="onNoCorrespondingFlux()">No Infrared</button>
          <button type="button" class="btn btn-primary col-xs-offset-5 done" data-ng-click="onDone()">Done</button>
        </div>
        <div ng-switch-when="2">
          <button type="button" class="btn btn-primary back" data-ng-click="onCancel()">Cancel</button>
          <button type="button" class="btn btn-primary next-radio" data-ng-click="onNextRadio()">Mark Another</button>
          <button type="button" class="btn btn-primary col-xs-offset-5 done" data-ng-click="onFinish()">Finish</button>
        </div>
        <div ng-switch-when="3">
          <button type="button" class="btn btn-default" data-ng-click="onFavorite($event)">Favorite</button>
          <button type="button" class="btn btn-default" data-ng-click="onDiscuss()">Discuss</button>
          <button type="button" class="btn btn-primary col-xs-offset-7 next" data-ng-click="onNext()">Next</button>
        </div>
      </div>
     </div>
    </div>
  </div>
</div>
"""
