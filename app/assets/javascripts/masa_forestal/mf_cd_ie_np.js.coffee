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

  $('#checkall_ge').click ->
    $('#tbody_checkboxes input').prop('checked', this.checked);

  $('#checkall_cf').click ->
    $('#tbody_calidad_checks input').prop('checked', this.checked);

  $('#tipo_parcela_inventario_select').on 'change', ->
    $('#parcela').empty()
    $.ajax
      type: 'POST'
      url: '/dynamic_select/num_parcela'
      dataType: 'HTML'
      data:
        tipo_parcela_inventario_id: $('#tipo_parcela_inventario_select').val()
      success: (data) ->
        datosp = JSON.parse(data)
        $.each datosp[0].parcelas_inventario, (ind, elem) ->
          $('#parcela').append('<option value="' + elem['id'] + '">' + elem['codigo'] + '</option>')
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        alert("No existe parcelas para este inventario")

  $('#procesar_mf_xcd').click ->
    $("#table_xcd").empty()
    grupo_especies = new Array()
    calidades = new Array()
    $(this).prop('disabled', 'disabled')
    $('#table_reporte_mf_xcd_div').empty()
    $('#loading_reporte_mf_xcd').show()
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
      url: '/masa_forestal/load_table_mf_xcd'
      dataType: 'HTML'
      data:
        check_especie:  check_especie
        especie_id: $('#especie_select').val()
        tipo_parcela_inventario_id: $('#tipo_parcela_inventario_select').val()
        parcela: $('#parcela').val()
        amplitud_cd: $('#amplitud_cd_field').val()
        especie: $('#especie_select').val()
        grupo_especies: grupo_especies
        calidades: calidades
      success: (data) ->
        if data == ''
          $('#loading_reporte_mf_xcd').hide()
          $('#tablareporte_xcd').hide()
          alert("No existen registros para está consulta")
        else
          datos = JSON.parse(data)
          $('#loading_reporte_mf_xcd').hide()
          $('#tablareporte_xcd').show()
          $.each datos[0]['masa_forestal'], (ind, elem) ->
            $("#table_xcd").append("<tr><td class = 'text-right'>" + elem['dap_inicio'] + '-' + elem['dap_final'] + "</td>
                                          <td class = 'text-right'>" + elem['densidad'] + "</td>
                                          <td class = 'text-right'>" + elem['area_basal'] + "</td>
                                          <td class = 'text-right'>" + elem['volumen'] + "</td></tr>")
          $("#datatable-mf-xcd").tablesorter()
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        $('#loading_reporte_mf_xcd').hide()
        $('#tablareporte_xcd').hide()
        alert("No existe registros para está consulta o existen criterios de búsqueda no seleccionados")


  $('#printPdf').click ->
    data = []
    height = 0
    doc = undefined
    doc = new jsPDF("p", "pt", "a4", true)
    doc.setFont "times", "normal"
    doc.setFontSize 14
    doc.text 40, 40, "REPORTE DE LA MASA FORESTAL x CATEGORIA DIAMETRICA"
    doc.setFontSize 8
    data = []
    data = doc.tableToJson("datatable-mf-xcd")
    height = doc.drawTable(data,
      xstart: 10
      ystart: 10
      tablestart: 80
      marginleft: 10
      xOffset: 10
      yOffset: 10
    )
    doc.save 'reporte_CD.pdf'