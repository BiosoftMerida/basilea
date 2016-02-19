#= require treeGrid/jquery.treegrid
#= require treeGrid/jquery.treegrid.bootstrap3

jQuery(document).ready ($) ->

  $("#table-body-municipio > [class!='estado_1']").hide()
  $('#check_all_ubicacion').prop('checked', $('.check_box_1:not(:checked)').length == 0)

  iniciar_treegrid()

  $('#estado').change ->
    est = $('#estado').val()

    $("#table-body-municipio > [class!='estado_"+est+"']").hide()
    $("#table-body-municipio > [class='estado_"+est+"']").show()
    $('#check_all_ubicacion').prop('checked', false)
    $('#check_all_ubicacion').prop('checked', $('.check_box_'+est+':not(:checked)').length == 0)

  $('#check_all_ubicacion').click (e) ->
    est = $('#estado').val()
    $('.check_box_'+est).prop('checked', $(this).is(':checked'))
    return

  $(':checkbox[class^="check_box_"]').click ->
    est = $('#estado').val()
    $('#check_all_ubicacion').prop('checked', $('.check_box_'+est+':not(:checked)').length == 0)

  $(".form_include_ubicacion_territorial").bind "submit", ->
    $(this).append($('#myModalUbicacionTerritorial'))


window.iniciar_treegrid = () ->
  $(".tree-edt").treegrid
    expanderExpandedClass: "glyphicon glyphicon-minus"
    expanderCollapsedClass: "glyphicon glyphicon-plus"


