
template = """
<div class="classifier row" data-ng-controller="ClassifierCtrl">
  <div class="viewport col-lg-4">
    <img data-ng-src="{{ getRadioSource() }}">
    <img class="image-opacity" data-ng-src="{{ getInfraredSource() }}">
    
    <div id="svg-contours" class='contours marking'>
      <svg xmlns="http://www.w3.org/2000/svg" class="svg-contours">
        <path ng-repeat="c in contours" class="svg-contour" ng-click="onContour($event)" ng-attr-contourid="{{$index}}" ng-attr-src="{{ src }}" ng-attr-d="{{ drawContour(c) }}"></path>
          
          <circle ng-repeat="c in circles" ng-attr-cx="{{c.x}}" ng-attr-cy="{{c.y}}" ng-attr-r="{{c.radius}}"></circle>
      </svg>
    </div>
    
  </div>
  
  <div class="workflow col-lg-4">
    <input type="range" min="0" max="1" step="0.01" data-ng-model="opacity">
    <input type="checkbox" data-ng-model="showContours">
    
    <!--
    <br><br>
    <input type="range" min="3" max="10" step="1" data-ng-model="level" ng-mouseup="updateContourParam()">
    <br><br>
    <input type="range" min="0" max="1000" step="1" data-ng-model="min" ng-mouseup="updateContourParam()">
    <input type="range" min="0" max="1000" step="1" data-ng-model="max" ng-mouseup="updateContourParam()">
    -->
      
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