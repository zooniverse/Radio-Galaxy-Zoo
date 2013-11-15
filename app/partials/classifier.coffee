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
            <p>Category caption goes here.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/JwLkoWf.png" / />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/5I6c3X5.png" />
          </div>

          <div class="row">
            <img src="http://i.imgur.com/CEkerlE.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/NOsdJJ1.png" />
          </div>

          <div class="row">
            <img src="http://i.imgur.com/lLTWokz.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/HOVImG.png" />
          </div>
        </div>

        <div ng-switch-when="extended">
          <div class="row">
            <p>Category caption goes here.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/8MhmWG9.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/4DC1WkO.png" />
          </div>

          <div class="row">
            <img src="http://i.imgur.com/SBkzZMG.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/rcRecZO.png" />
          </div>

          <div class="row">
            <img src="http://i.imgur.com/V4TpnUN.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/IqV2BLN.png" />
          </div>

          <div class="row">
            <img src="http://i.imgur.com/53n1OGX.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/ZitAkd0.png" />
          </div>

          <div class="row">
            <img src="http://i.imgur.com/aiba51W.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/BimKgCB.png" />
          </div>

          <div class="row">
            <img src="http://i.imgur.com/uhI3xNz.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/vbs1A2V.png" />
          </div>

          <div class="row">
            <img src="http://i.imgur.com/0GZawBb.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/fy8LHdK.png" />
          </div>

          <div class="row">
            <img src="http://i.imgur.com/Ij5ClIS.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/EWcIUe2.png" />
          </div>
        </div>

        <div ng-switch-when="multiple">
          <div class="row">
            <p>Category caption goes here.</p>
          </div>
          <div class="row">
            <img src="http://i.imgur.com/T0qP6Vo.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/MuGZdqP.png" />
          </div>

          <div class="row">
            <img src="http://i.imgur.com/uhMPY8Y.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/eruqmTl.png" />
          </div>

          <div class="row">
            <img src="http://i.imgur.com/6OBTkhC.png" />
          </div>
          <div class="row">
            <img src="http://i.imgur.com/pmPhCkR.png" />
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
