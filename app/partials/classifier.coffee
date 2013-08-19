
template = """
<div class="classifier row" data-ng-controller="ClassifierCtrl">
  
  <div class="viewport col-md-7">
    <img data-ng-src="{{ getRadioSource() }}">
    <img class="infrared" data-ng-src="{{ getInfraredSource() }}">
    
    <div id="svg-contours" class='contours marking' ng-class="{dashed: step==2}">
      <svg xmlns="http://www.w3.org/2000/svg" class="svg-contours">
        <path ng-repeat="c in contours" class="svg-contour" ng-click="onContour($event)" ng-attr-contourid="{{$index}}" ng-attr-src="{{ src }}" ng-attr-d="{{ drawContour(c) }}"></path>
      </svg>
    </div>
    
  </div>
  
  <div class="workflow col-md-5 col-md-offset-1">
    
    <div class="row controls">
      <div class="image-slider col-md-6">
        <p>IR</p>
        <input class='image-opacity' type="range" min="0" max="1" step="0.01" value="0">
        <p>Radio</p>
      </div>
      <span class="toggle-contours col-md-3">hide contours</span>
      
      <span class="message col-md-3">{{ getStepMessage() }}</span>
    </div>
    
    <div class='row instruction'>
      <div ng-switch on="step">
        <div col-md-12 ng-switch-when="1">
          <p>Select contours representing the radio flux.</p>
        </div>
        
        <div ng-switch-when="2">
          <p>Identify the infrared source.</p>
        </div>
        
        <div ng-switch-when="3">
          <p>Great work, you helped science!</p>
        </div>
      </div>
    </div>
    
    <div class='examples'>
      <img src="http://imgs.xkcd.com/comics/balloon_internet.png">
    </div>
    
    <div class='buttons row'>
      <div ng-switch on="step">
        <div ng-switch-when="1" class="col-md-6 col-md-offset-7">
          <button type="button" class="btn btn-default" data-ng-click="onNoFlux()">No flux</button>
          <button type="button" class="btn btn-primary continue" data-ng-click="onContinue()" disabled>Continue</button>
        </div>
        <div ng-switch-when="2" class="col-md-6 col-md-offset-7">
          <button type="button" class="btn btn-default" data-ng-click="onNoCorrespondingFlux()">No Infrared</button>
          <button type="button" class="btn btn-primary" data-ng-click="onDone()">Done</button>
        </div>
        <div ng-switch-when="3">
          <button type="button" class="btn btn-default col-md-2" data-ng-click="onFavorite()">Favorite</button>
          <button type="button" class="btn btn-default col-md-2" data-ng-click="onDiscuss()">Discuss</button>
          <button type="button" class="btn btn-primary col-md-offset-6" data-ng-click="onNext()">Next</button>
        </div>
      </div>
    </div>
    
  </div>
</div>
"""


module.exports = template