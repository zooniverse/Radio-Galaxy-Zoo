
template = """
<div class="classifier row" data-ng-controller="ClassifierCtrl">
  
  <div class="viewport col-md-5">
    <img data-ng-src="{{ getRadioSource() }}">
    <img class="infrared" data-ng-src="{{ getInfraredSource() }}">
    
    <div id="svg-contours" class='contours marking step-{{getStep()}}' ng-class="{'fade-contour': !getShowContours()}">
      <svg xmlns="http://www.w3.org/2000/svg" class="svg-contours"></svg>
    </div>
    
  </div>
  
  <div class="workflow col-md-6 col-md-offset-1">
    
    <div class="row controls">
      <div class="image-slider col-md-6">
        <p class="band" data-band="radio">Radio</p>
        <input class='image-opacity' type="range" min="0" max="1" step="0.01" value="0">
        <p class="band" data-band="infrared">IR</p>
      </div>
      <span class="toggle-contours col-md-3">{{getShowContours() ? 'hide' : 'show'}} contours</span>
      <span class="message col-md-3">{{getStep()==3 ? 'Complete!' : "Step " + getStep() + " of 2"}}</span>
    </div>
    
    <div class='row instruction'>
      <div ng-switch on="getStep()">
        <div col-md-12 ng-switch-when="1">
          <p>Select the contour(s) representing a radio flux.</p>
        </div>
        
        <div ng-switch-when="2">
          <p>Identify the infrared source(s).</p>
        </div>
        
        <div ng-switch-when="3">
          <p>Great work, you helped science!</p>
        </div>
      </div>
    </div>
    
    <div class='examples row'>
      <div class="row">
        <p class="col-md-2">Examples:</p>
        <span class="col-md-4 example" ng-class="{'active': getExample()=='single-compact-source'}" data-type="single-compact-source">Single Compact Source</span>
        <span class="col-md-3 example" ng-class="{'active': getExample()=='multiple-sources'}" data-type="multiple-sources">Multiple Sources</span>
        <span class="col-md-3 example" ng-class="{'active': getExample()=='extended-source'}" data-type="extended-source">Extended Source</span>          
      </div>
      
      <div class="row content" ng-show=getExample()=="single-compact-source">
        <div class="col-md-5 image">
          <img src="images/example/single-compact-source.jpg">
        </div>
        <div class="col-md-7">Compact radio sources most frequently look like this. A relatively faint radio source sits squarely on an infrared source. Both the infrared and radio emission are likely to come from the same object. The tiny specks towards the upper left corner are noise and probably do not reflect true emission.</div>
      </div>
      
      <div class="row content" ng-show=getExample()=="multiple-sources">
        <div class="col-md-5 image">
          <img src="images/example/multiple-sources.jpg">
        </div>
        <div class="col-md-7">This radio source shows a "core-jet" structure, which means that a bright, compact radio component (the core) has a single-sided, long extension toward the lower right (the jet). Here, the core coincides with a bright infrared object, which is identified as its counterpart.<br><br>A second, compact radio source is seen in the upper left; since there's another infrared counterpart and it isn't aligned with the first jet, this is likely a separate source in the same field.</div>
      </div>
      
      <div class="row content" ng-show=getExample()=="extended-source">
        <div class="col-md-5 image">
          <img src="images/example/extended-source.jpg">
        </div>
        <div class="col-md-7">This radio source has a bright peak near the center, but also shows extended emission on both sides of its jet. In particular, the radio emission to the lower left has begun expanding and is much wider than the jet closer to the source. The bright infrared image toward the center is likely the only counterpart.</div>
      </div>
    </div>
    
    <div class='buttons row'>
      <div ng-switch on="getStep()">
        <div ng-switch-when="1" class="col-md-6 col-md-offset-8">
          <button type="button" class="btn btn-default no-flux" data-ng-click="onNoFlux()">No flux</button>
          <button type="button" class="btn btn-primary continue" data-ng-click="onContinue()" disabled>Continue</button>
        </div>
        <div ng-switch-when="2" class="col-md-6 col-md-offset-8">
          <button type="button" class="btn btn-primary next-radio" data-ng-click="onNextRadio()">Select Another Radio</button>
          <button type="button" class="btn btn-default" data-ng-click="onNoCorrespondingFlux()">No Infrared</button>
          <button type="button" class="btn btn-primary done" data-ng-click="onDone()">Done</button>
        </div>
        <div ng-switch-when="3">
          <button type="button" class="btn btn-default" data-ng-click="onFavorite($event)">Favorite</button>
          <button type="button" class="btn btn-default" data-ng-click="onDiscuss()">Discuss</button>
          <button type="button" class="btn btn-primary col-md-offset-7 next" data-ng-click="onNext()">Next</button>
        </div>
      </div>
    </div>
    
  </div>
</div>
"""


module.exports = template
