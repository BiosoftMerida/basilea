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


  $('#procesar_estadistica').click ->
    grupo_especies = new Array()
    calidades = new Array()
    $(this).prop('disabled', 'disabled')
    $('#table_reporte_mf_estadistica_div').empty()
    $('#loading_reporte_estadistica').show()
    $('#tbody_checkboxes input').each ->
      if (this.checked) && !(this.disabled)
        grupo_especies.push($(this).val())
    $('#tbody_calidad_checks input').each ->
      if (this.checked) && !(this.disabled)
        calidades.push($(this).val())
    $.ajax
      type: 'POST'
      url: '/masa_forestal/load_table_estadistica'
      dataType: 'JSON'
      data:
        check_especie:  $('#especie_true').val()
        especie_id: $('#especie_select').val()
        tipo_parcela_inventario_id: $('#tipo_parcela_inventario_select').val()
        especificacion_diametrica: $('#especificacion_diametrica_field').val()
        especie: $('#especie_select').val()
        grupo_especies: grupo_especies
        calidades: calidades
        nivel_confianza:  $('input:radio[name=nivel_confianza]:checked').val()
      success: (data) ->
        if jQuery.isEmptyObject(data[0]['masa_forestal'])
          $('#loading_reporte_estadistica').hide()
          $('#tablareporte_estadistica').hide()
          alert("No existen registros para está consulta")
        else
          $('#loading_reporte_estadistica').hide()
          $('#tbody_estadistica').empty()
          $('#tablareporte_estadistica').show()
          $('#datatable-mf-estadistica').append(data)
          console.log(data[0]['masa_forestal'])
          for mf, index in data[0]['masa_forestal']
            $("#tbody_estadistica").append("<tr><td class = 'text-right'>"+mf.variable+"</td><td class = 'text-right'>"+mf.promedio+"</td><td class = 'text-right'>"+mf.variaza+
              "</td><td class = 'text-right'>"+mf.desv_tipica+"</td><td class = 'text-right'>"+mf.coef_variacion+"</td><td class = 'text-right'>"+mf.error_media+
              "</td><td class = 'text-right'>"+mf.error_muestreo+"</td><td class = 'text-right'>"+mf.error_muestreo_porc+"</td><td class = 'text-right'>"+mf.lim_inf_conf+"</td><td class = 'text-right'>"+mf.lim_sup_conf+"</td></tr>")
          $("#n").val(data[0]['n'])
          $("#datatable-mf-estadistica").tablesorter()
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        $('#loading_reporte_estadistica').hide()
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
    doc.text 40, 40, "ESTADISTICAS"
    doc.setFontSize 8
    data = []
    data = doc.tableToJson("datatable-mf-estadistica")
    height = doc.drawTable(data,
      xstart: 10
      ystart: 10
      tablestart: 80
      marginleft: 10
      xOffset: 10
      yOffset: 10
    )
    doc.save 'reporte_estadisticas.pdf'