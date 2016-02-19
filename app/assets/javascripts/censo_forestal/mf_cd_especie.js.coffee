
#= require datable

jQuery(document).ready ($) ->

  $('#btn_procesar').click ->
    $(this).prop('disabled', 'disabled')
    $('#msg_procesando').show()
    $('#div_procesando').empty()
    $.ajax
      type: 'POST'
      url: '/censo_forestal/mf_cd_especie'
      dataType: 'JSON'
      data:
        variable_mf: $('input:radio[name=variable_mf]:checked').val()
        bloque_manejo_id: $('#bloque_select').val()
      success: (data) ->
        $('#msg_procesando').hide()
        $('#div_table_resultados').show()
        $('#tbody_resultados').empty()
        $('#table_resultados').append(data)
        console.log(data[0]['masa_forestal'])
        $.each data[0]['masa_forestal'], (ind, elem) ->
          $("#tbody_resultados").append("<tr><td>"+ind+"</td>
            <td class = 'text-right'>"+elem[0]+"</td><td class = 'text-right'>"+elem[1]+"</td>
            <td class = 'text-right'>"+elem[2]+"</td><td class = 'text-right'>"+elem[3]+"</td>
            <td class = 'text-right'>"+elem[4]+"</td><td class = 'text-right'>"+elem[5]+"</td>
            <td class = 'text-right'>"+elem[6]+"</td><td class = 'text-right'>"+elem[7]+"</td>
            <td class = 'text-right'>"+elem[8]+"</td><td class = 'text-right'>"+elem[9]+"</td></tr>")
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
    doc.text 40, 40, "CENSO FORESTAL - REPORTE DE LA MASA FORESTAL X CD X ESPECIE"
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
    doc.save 'reporte_mf_cd_especie.pdf'



