
#= require datable
#= require "./fisiografia_select"

jQuery(document).ready ($) ->

  $('#btn_procesar').click ->
    calidades = new Array()
    vitalidades = new Array()
    $(this).prop('disabled', 'disabled')
    $('#msg_procesando').show()
    $('#div_procesando').empty()
    $('#tbody_calidad_checks input').each ->
      if (this.checked) && !(this.disabled)
        calidades.push($(this).val())
    $('#tbody_vitalidad_checks input').each ->
      if (this.checked) && !(this.disabled)
        vitalidades.push($(this).val())
    $.ajax
      type: 'POST'
      url: '/censo_forestal/mf_subcuenca'
      dataType: 'JSON'
      data:
        calidades: calidades
        vitalidades: vitalidades
        especificacion_diametrica: $('#especificacion_diametrica').val()
        sub_paisaje_id: $('#sub_paisaje_select').val()
        paisaje_id: $('#paisaje_select').val()
        gran_paisaje_id: $('#gran_paisaje_select').val()
      success: (data) ->
        $('#msg_procesando').hide()
        $('#div_table_resultados').show()
        $('#tbody_resultados').empty()
        $('#table_resultados').append(data)
        console.log(data[0]['masa_forestal'])
        for mf, index in data[0]['masa_forestal']
          $('#tbody_resultados').append("<tr><td>"+mf.nombre_comun+"</td><td class = 'text-right'>"+mf.narb_padres+
            "</td><td class = 'text-right'>"+mf.ab_padres+"</td><td class = 'text-right'>"+mf.narb_aprov+
            "</td><td class = 'text-right'>"+mf.ab_aprov+"</td><td class = 'text-right'>"+mf.vol_aprov+
            "</td><td class = 'text-right'>"+mf.dap_prom+"</td><td class = 'text-right'>"+mf.altura_prom+
            "</td><td class = 'text-right'>"+mf.vol_prom+"</td><td class = 'text-right'>"+mf.narb_prom_ha+
            "</td><td class = 'text-right'>"+mf.vol_prom_ha+"</td></tr>")
        $("#table_resultados").tablesorter()
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        $('#msg_procesando').hide()
        alert("No existe registros para esta consulta o existen campos no seleccionados")


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
    doc.text 40, 40, "CENSO FORESTAL - REPORTE DE LA MASA FORESTAL - UPA"
    doc.setFontSize 8
    data = []
    data = doc.tableToJson("table_resultados")
    height = doc.drawTable(data,
      xstart: 10
      ystart: 10
      tablestart: 80
      marginleft: 10
      xOffset: 10
      yOffset: 10
    )
    doc.save 'reporte_mf_upa.pdf'


