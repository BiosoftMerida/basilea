#= require datable
jQuery(document).ready ($) ->

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

  $('#procesar_mf_matriz').click ->
    $("#table_matriz").empty()
    calidades = new Array()
    $(this).prop('disabled', 'disabled')
    $('#table_reporte_mf_matriz_div').empty()
    $('#loading_reporte_mf_matriz').show()
    $('#tbody_calidad_checks input').each ->
      if (this.checked) && !(this.disabled)
        calidades.push($(this).val())
    $.ajax
      type: 'POST'
      url: '/masa_forestal/load_table_mf_matriz'
      dataType: 'HTML'
      data:
        tipo_parcela_inventario_id: $('#tipo_parcela_inventario_select').val()
        parcela: $('#parcela').val()
        variable_mf: $('input:radio[name=variable_mf]:checked').val()
        calidades: calidades
      success: (data) ->
        if jQuery.isEmptyObject(data)
          $('#loading_reporte_mf_matriz').hide()
          $('#tablareporte_matriz').hide()
          alert("No existen registros para está consulta")
        else
          datos = JSON.parse(data)
          $('#loading_reporte_mf_matriz').hide()
          $('#tablareporte_matriz').show()
          $.each datos[0]['masa_forestal_matriz'], (ind, elem) ->
            $("#table_matriz").append("<tr><td>"+ind+"</td>
                                        <td >"+elem[0]+"</td>
                                        <td>"+elem[1]+"</td>
                                        <td>"+elem[2]+"</td>
                                        <td>"+elem[3]+"</td>
                                        <td>"+elem[4]+"</td>
                                        <td>"+elem[5]+"</td>
                                        <td>"+elem[6]+"</td>
                                        <td>"+elem[7]+"</td>
                                        <td>"+elem[8]+"</td></tr>")
          $("#datatable-mf-matriz").tablesorter()
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        $('#loading_reporte_mf_matriz').hide()
        alert("No existe registros para está consulta o existen campos no seleccionados")


  $('#printPdf').click ->
    data = []
    height = 0
    doc = undefined
    doc = new jsPDF("landscape", "pt", "a4", true)
    doc.setFont "times", "normal"
    doc.setFontSize 14
    doc.text 40, 40, "REPORTE DE LA MASA FORESTAL - MATRIZ ADRD"
    doc.text 40, 60, "Especificación Diamétrica"
    doc.setFontSize 8
    data = []
    data = doc.tableToJson("datatable-mf-matriz")
    height = doc.drawTable(data,
      xstart: 10
      ystart: 10
      tablestart: 80
      marginleft: 10
      xOffset: 10
      yOffset: 10
    )
    doc.save 'reporte_ADRD.pdf'

