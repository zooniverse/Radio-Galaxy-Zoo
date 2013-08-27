
Biographies = require '../content/biographies'


Team = ($scope) ->
  $scope.team = Biographies

  $scope.getTeamLength = ->
    return [0..$scope.team.length]

module.exports = Team