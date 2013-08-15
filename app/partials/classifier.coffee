
template = """
<div class="classifier row" data-ng-controller="ClassifierCtrl">
  
  <div class="viewport col-md-6">
    <img data-ng-src="{{ getRadioSource() }}">
    <img class="infrared" data-ng-src="{{ getInfraredSource() }}">
    
    <div id="svg-contours" class='contours marking' ng-class="{dashed: step==2}">
      <svg xmlns="http://www.w3.org/2000/svg" class="svg-contours">
        <path ng-repeat="c in contours" class="svg-contour" ng-click="onContour($event)" ng-attr-contourid="{{$index}}" ng-attr-src="{{ src }}" ng-attr-d="{{ drawContour(c) }}"></path>
      </svg>
    </div>
    
  </div>
  
  <div class="workflow col-md-offset-6">
    
    <span>Infrared</span>
    <input class='image-opacity' type="range" min="0" max="1" step="0.01" value="0">
    <span>Radio</span>
    <input type="checkbox" data-ng-model="showContours">
    
    <span>Step 1 of 2</span>
    
    <div ng-switch on="step">
      <div ng-switch-when="1">
        
        <p>Select contour(s) representing the radio flux.</p>
        <div class="examples">
          <p>Here are some examples of marked sources.</p>
        </div>
        
        <div class="buttons">
          <button data-ng-click="onNoFlux()">No flux</button>
          <button data-ng-click="onContinue()">Continue</button>
        </div>
      </div>
      
      <div ng-switch-when="2">
        <p>Identify the infrared source.</p>
        <div class="examples">
          <p>Look for region(s) where the isolines seem to eminate from.</p>
        </div>
        <button data-ng-click="onDone()">Done</button>
      </div>
      
    </div>
    
  </div>
</div>
"""


module.exports = template