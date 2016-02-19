#= require datable

angular
.module('mf_cd', [])
.controller( "mf_cd_ctlr", @mf_cd_ctlr = ($scope,$http) ->
    $scope.bloque_manejo_id = 0
    $scope.variable_mf = 'Volumen'
    $scope.mostrar_resultados = false
    $scope.mostrar_procesando = false

    $scope.procesarConsulta = () ->
      console.log("Entro a procesar la consulta")
      $scope.mostrar_procesando = true
      datos = {bloque_manejo_id: $scope.bloque_manejo_id,variable_mf: $scope.variable_mf}
      $http.post("/censo_forestal/mf_cd_angular",datos)
        .success = (respuesta) ->
          $scope.masa_forestal = respuesta.data
          console.log($scope.masa_forestal)
          $scope.mostrar_resultados = true
          $scope.mostrar_procesando = false

)


