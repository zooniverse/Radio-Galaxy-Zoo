
template = """
<div class="classifier row" data-ng-controller="ClassifierCtrl">
  <div class="viewport span4">
    <img data-ng-src="{{ getRadioSource() }}">
    <img class="image-opacity" data-ng-src="{{ getInfraredSource() }}">
    <div id="contours" class='contours'></div>
  </div>
  
  <div class="workflow span4">
    <input type="range" min="0" max="1" step="0.01" data-ng-model="opacity">
    <input type="checkbox" data-ng-model="showContours">
    
    <br><br>
    <input type="range" min="3" max="10" step="1" data-ng-model="level" ng-mouseup="updateContourParam()">
    <br><br>
    <input type="range" min="0" max="1000" step="1" data-ng-model="min" ng-mouseup="updateContourParam()">
    <input type="range" min="0" max="1000" step="1" data-ng-model="max" ng-mouseup="updateContourParam()">
    
    
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