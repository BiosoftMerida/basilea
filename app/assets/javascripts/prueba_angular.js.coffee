angular
  .module('Hello', [])
  .controller( "HelloCntl", @HelloCntl = ($scope) ->
    $scope.name = ''
  )