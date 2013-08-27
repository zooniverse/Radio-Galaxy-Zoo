template = """
<div class='team' data-ng-controller="TeamCtrl">
  <h3>The Radio Galaxy Zoo Team</h3>
  
  <div ng-repeat="index in getTeamLength()">
    <div ng-if="$index % 3 == 0" class="row">
      <div ng-repeat="person in team.slice($index, $index + 3)" class="col-md-4">
        <h5>{{person.name}} <a ng-if="person.twitter" href="http://twitter.com/{{person.twitter}}">@{{person.twitter}}</a></h5>
        <p>{{person.institution}}</p>
        <p>{{person.bio}}</p>
      </div>
    </div>
  </div>
  
</div>
"""

module.exports = template