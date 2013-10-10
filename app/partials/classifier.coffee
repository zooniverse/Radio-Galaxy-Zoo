
template = """
<div class="classifier row" data-ng-controller="ClassifierCtrl">
  
  <div class="col-xs-6">
    <div class="viewport">
      <img data-ng-src="{{ getRadioSource() }}">
      <img class="infrared" data-ng-src="{{ getInfraredSource() }}">
      
      <div id="svg-contours" class='contours marking step-{{getStep()}}' ng-class="{'fade-contour': !getShowContours()}">
        <svg xmlns="http://www.w3.org/2000/svg" class="svg-contours"></svg>
      </div>
    </div>
  </div>
  
  <div class="workflow col-xs-6">
    
    <div class="row controls">
      <div class="image-slider col-xs-6">
        <p class="band" data-band="radio">Radio</p>
        <input class='image-opacity' type="range" min="0" max="1" step="0.01" value="0">
        <p class="band" data-band="infrared">IR</p>
      </div>
      <span class="toggle-contours col-xs-3">{{getShowContours() ? 'hide' : 'show'}} contours</span>
      <span class="message col-xs-3">{{getStep()==3 ? 'Complete!' : "Step " + getStep() + " of 2"}}</span>
    </div>
    
    <div class='row instruction'>
      <div ng-switch on="getStep()">
        <div col-xs-12 ng-switch-when="1">
          <p>Select the contour(s) representing the radio emission.</p>
        </div>
        
        <div ng-switch-when="2">
          <p>Identify the infrared source.</p>
        </div>
        
        <div ng-switch-when="3">
          <p>Great work, you helped science!</p>
        </div>
      </div>
    </div>
    
    <div class='examples row'>
      <div class="row example-selection">
        <p class="col-xs-2">Examples:</p>
        <span class="col-xs-4 example" ng-class="{'active': getExample()=='single-compact-source'}" data-type="single-compact-source">Single Compact Srcs</span>
        <span class="col-xs-3 example" ng-class="{'active': getExample()=='multiple-sources'}" data-type="multiple-sources">Multiple Srcs</span>
        <span class="col-xs-3 example" ng-class="{'active': getExample()=='extended-source'}" data-type="extended-source">Extended Srcs</span>          
      </div>
      
      <div class="row content" ng-show=getExample()=="single-compact-source">
        <div class="col-xs-5 image">
          <img src="images/example/single-compact-source.jpg">
        </div>
        <div class="col-xs-7">Compact radio sources most frequently look like this. A relatively faint radio source sits squarely on an infrared source. Both the infrared and radio emission are likely to come from the same object. The tiny specks towards the upper left corner are noise and probably do not reflect true emission.</div>
      </div>
      
      <div class="row content" ng-show=getExample()=="multiple-sources">
        <div class="col-xs-5 image">
          <img src="images/example/multiple-sources.jpg">
        </div>
        <div class="col-xs-7">The center radio source shows a "core-jet" structure, with a bright, compact component (the core) and a long extension (the jet) to the lower right. The core coincides with a bright infrared counterpart. A second radio source is in the upper left; since it has its own infrared counterpart and isn't aligned with the first jet, this is likely a separate galaxy.</div>
      </div>
      
      <div class="row content" ng-show=getExample()=="extended-source">
        <div class="col-xs-5 image">
          <img src="images/example/extended-source.jpg">
        </div>
        <div class="col-xs-7">This radio source has a bright peak near the center, but also shows extended emission on both sides of its jet. In particular, the radio emission to the lower left has begun expanding and is much wider than the jet closer to the source. The bright infrared image toward the center is likely the only counterpart.</div>
      </div>
    </div>
    
    <div class='buttons row step-{{getStep()}}'>
      <div ng-switch on="getStep()">
        <div ng-switch-when="1" class="col-xs-12">
          <button type="button" class="btn btn-default no-flux" data-ng-click="onNoFlux()">Nothing here</button>
          <button type="button" class="btn btn-primary continue" data-ng-click="onContinue()" disabled>Continue</button>
        </div>
        <div ng-switch-when="2">
          <button type="button" class="btn btn-primary next-radio" data-ng-click="onNextRadio()">Select Another Radio Complex</button>
          <button type="button" class="btn btn-default col-xs-offset-3 no-infrared" data-ng-click="onNoCorrespondingFlux()">No Infrared</button>
          <button type="button" class="btn btn-primary col-xs-offset-5 done" data-ng-click="onDone()">Done</button>
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
"""


module.exports = template
