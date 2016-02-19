#= require datable

jQuery(document).ready ($) ->
  $('#tipo_parcela_inventario').on 'change', ->
    $('#parcela').empty()
    $.ajax
      type: 'POST'
      url: '/dynamic_select/num_parcela'
      dataType: 'HTML'
      data:
        tipo_parcela_inventario_id: $('#tipo_parcela_inventario').val()
      success: (data) ->
        datosp = JSON.parse(data)
        $.each datosp[0].parcelas_inventario, (ind, elem) ->
          $('#parcela').append('<option value="' + elem['id'] + '">' + elem['codigo'] + '</option>')
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        alert("No existe parcelas para este inventario")

  $('#procesar_mf_xcriterio').click ->
    $("#table_xcriterio").empty()
    $('#table_reporte_mf_xcriterio_div').empty()
    $('#loading_reporte_mf_xcriterio').show()
    $.ajax
      type: 'POST'
      url: '/masa_forestal/load_table_mf_criterio'
      dataType: 'HTML'
      data:
        nivel: $('#nivel').val()
        tipo_parcela_inventario_id: $('#tipo_parcela_inventario').val()
        parcela: $('#parcela').val()
        especificacion: $('#especificacion_diametrica').val()
        check_criterio:  $('input:radio[name=criterio]:checked').val()
      success: (data) ->
        if data == ''
          $('#loading_reporte_mf_xcriterio').hide()
          $('#tablareporte_xcriterio').hide()
          alert("No existen registros para está consulta")
        else
          datos = JSON.parse(data)
          $('#loading_reporte_mf_xcriterio').hide()
          $('#tablareporte_xcriterio').show()
          $.each datos[0]['masa_forestal'], (ind, elem) ->
            $("#table_xcriterio").append("<tr><td class = 'text-right'>"+elem['criterio']+"</td>
                                        <td class = 'text-right'>"+elem['densidad']+"</td>
                                        <td class = 'text-right'>"+elem['area_basal']+"</td>
                                        <td class = 'text-right'>"+elem['dap']+"</td>
                                        <td class = 'text-right'>"+elem['altura_fuste']+"</td>
                                        <td class = 'text-right'>"+elem['volumen']+"</td>" +
                                        "<td class = 'text-right'>"+elem['abundancia_efectiva']+"</td></tr>")
          $("#datatable-mf-xcriterio").tablesorter()
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        $('#loading_reporte_mf_xcriterio').hide()
        alert("No existe registros para está consulta o existen campos no seleccionados")



  $('#printPdf').click ->
    data = []
    height = 0
    doc = undefined
    doc = new jsPDF("landscape", "pt", "a4", true)
    doc.setFont "times", "normal"
    doc.setFontSize 14
    doc.text 40, 40, "REPORTE DE LA MASA FORESTAL x CRITERIO FLORÍSTICO/CALIDAD"
    doc.setFontSize 8
    data = []
    data = doc.tableToJson("datatable-mf-xcriterio")
    height = doc.drawTable(data,
      xstart: 10
      ystart: 10
      tablestart: 80
      marginleft: 10
      xOffset: 10
      yOffset: 10
    )
    doc.save 'reporte_xcriterio.pdf'