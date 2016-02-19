

jQuery(document).ready ($) ->

  $('#gran_paisaje_select').on 'change', ->
    $('#paisaje_select').empty()
    $('#paisaje_select').append('<option value="' + ' ' + '">' +'Todos los Paisajes' + '</option>')
    $('#sub_paisaje_select').empty()
    $('#sub_paisaje_select').append('<option value="' + ' ' + '">' +'Todos los Sub Paisajes' + '</option>')
    if (Number) $('#gran_paisaje_select').val() > 0
      $.ajax
        type: 'POST'
        url: '/dynamic_select/dynamic_fisiografia_paisaje'
        dataType: 'JSON'
        data:
          gran_paisaje_id: $('#gran_paisaje_select').val()
        success: (data) ->
          $('#paisaje_select').empty()
          $('#paisaje_select').append('<option value="' + ' ' + '">' +'Todos los Paisajes' + '</option>')
          $('#sub_paisaje_select').empty()
          $('#sub_paisaje_select').append('<option value="' + ' ' + '">' +'Todos los Sub Paisajes' + '</option>')
          for paisaje, index in data[0]['paisajes']
            $('#paisaje_select').append('<option value="' + paisaje.id + '">' + paisaje.nombre + '</option>')


  $('#paisaje_select').on 'change', ->
    $('#sub_paisaje_select').empty()
    $('#sub_paisaje_select').append('<option value="' + ' ' + '">' +'Todos los Sub Paisajes' + '</option>')
    if (Number) $('#paisaje_select').val() > 0
      $.ajax
        type: 'POST'
        url: '/dynamic_select/dynamic_fisiografia_sub_paisaje'
        dataType: 'JSON'
        data:
          paisaje_id: $('#paisaje_select').val()
        success: (data) ->
          $('#sub_paisaje_select').empty()
          $('#sub_paisaje_select').append('<option value="' + ' ' + '">' +'Todos los Sub Paisajes' + '</option>')
          for sub_paisaje, index in data[0]['sub_paisajes']
            $('#sub_paisaje_select').append('<option value="' + sub_paisaje.id + '">' + sub_paisaje.nombre + '</option>')
