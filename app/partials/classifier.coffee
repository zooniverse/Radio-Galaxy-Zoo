
classifierTemplate = """
  <div class='classifier' data-ng-controller='ClassifierController'>
    <p>Help cross-match radio sources with infrared sources!</p>
    <div class='viewport' data-ng-click="onClick($event)">
      <img src="{{ currentSrc }}" >
      <div id="contours" class="contours"></div>
    </div>
    <div class='ui'>
      <button ng-click="setBand('ir')">Infrared</button>
      <button ng-click="setBand('radio')">Radio</button>
      <input type="range" name="level" min="3" max="5" step="1" data-ng-model="level">
      <input type="checkbox" data-ng-model="contours">
      <button data-ng-click="getSubject()">Submit</button>
    </div>
  </div>
"""


module.exports = classifierTemplate