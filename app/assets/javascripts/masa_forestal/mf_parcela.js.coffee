
#= require datable
jQuery(document).ready ($) ->


  if $('#especie_true').is(':checked')
    $('#especie_select').prop('disabled', false);
    $('#table_grupo_especies input[type=checkbox]').attr('disabled','true');
  else
    $('#especie_select').prop('disabled', 'disabled');
    $('#table_grupo_especies input[type=checkbox]').attr('disabled', false);

  $('#especie_true').click ->
    $('#especie_select').prop('disabled', false);
    $('#table_grupo_especies input[type=checkbox]').attr('disabled','true');

  $('#especie_false').click ->
    $('#especie_select').prop('disabled', 'disabled');
    $('#table_grupo_especies input[type=checkbox]').attr('disabled', false);


  $('#procesar_masa_parcela').click ->
    grupo_especies = new Array()
    calidades = new Array()
    $(this).prop('disabled', 'disabled')
    $('#table_reporte_masa_parcela_div').empty()
    $('#loading_reporte_masa_parcela').show()
    $('#tbody_checkboxes input').each ->
      if (this.checked) && !(this.disabled)
        grupo_especies.push($(this).val())
    $('#tbody_calidad_checks input').each ->
      if (this.checked) && !(this.disabled)
        calidades.push($(this).val())
    if $('#especie_true').is(':checked')
      check_especie = true
    else
      check_especie = false
    $.ajax
      type: 'POST'
      url: '/masa_forestal/load_table_masa_parcela'
      dataType: 'JSON'
      data:
        check_especie:  check_especie
        especie_id: $('#especie_select').val()
        tipo_parcela_inventario_id: $('#tipo_parcela_inventario_select').val()
        especificacion_diametrica: $('#especificacion_diametrica_field').val()
        especie: $('#especie_select').val()
        grupo_especies: grupo_especies
        calidades: calidades
      success: (data) ->
        console.log(jQuery.isEmptyObject(data[0]['masa_forestal']))
        if jQuery.isEmptyObject(data[0]['masa_forestal'])
          $('#loading_reporte_masa_parcela').hide()
          $('#tablareporte_parcela').hide()
          alert("No existen registros para está consulta")
        else
          $('#loading_reporte_masa_parcela').hide()
          $('#tbody_masa_forestal').empty()
          $('#tablareporte_parcela').show()
          $('#datatable-masa-parcela').append(data)
          for mf, index in data[0]['masa_forestal']
            $("#tbody_masa_forestal").append("<tr><td class = 'text-right'>"+mf.criterio+"</td><td class = 'text-right'>"+mf.densidad+"</td><td class = 'text-right'>"+mf.area_basal+
              "</td><td class = 'text-right'>"+mf.dap+"</td><td class = 'text-right'>"+mf.altura_fuste+"</td><td class = 'text-right'>"+mf.volumen+"</td><td class = 'text-right'>"+mf.abundancia_efectiva+"</td></tr>")
          $("#datatable-mf-parcela").tablesorter()
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        $('#loading_reporte_masa_parcela').hide()
        alert("No existe registros para está consulta o existen criterios de búsqueda no seleccionados")


  $('#checkall_ge').click ->
    $('#tbody_checkboxes input').prop('checked', this.checked);

  $('#checkall_cf').click ->
    $('#tbody_calidad_checks input').prop('checked', this.checked);


  $('#printPdf').click ->
    data = []
    height = 0
    doc = undefined
    doc = new jsPDF("landscape", "pt", "a4", true)
    doc.setFont "times", "normal"
    doc.setFontSize 14
    doc.text 40, 40, "REPORTE DE LA MASA FORESTAL x PARCELA"
    doc.setFontSize 8
    data = []
    data = doc.tableToJson("datatable-mf-parcela")
    height = doc.drawTable(data,
      xstart: 10
      ystart: 10
      tablestart: 80
      marginleft: 10
      xOffset: 10
      yOffset: 10
    )
    doc.save 'reporte_parcela.pdf'