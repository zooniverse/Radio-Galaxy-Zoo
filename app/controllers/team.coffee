
Biographies = require '../content/biographies'


Team = ($scope) ->
  $scope.team = Biographies.filter( (d) -> return d if d.bio? )

  $scope.getTeamLength = ->
    return [0..$scope.team.length]

module.exports = Team