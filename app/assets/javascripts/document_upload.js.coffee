jQuery(document).ready ($) ->
  $('.file').each ->
      animationHover this, 'pulse'
      return

  $('.popUp').popover
    trigger: "hover"
    html: true

    title: ->
      $(this).parent().find(".po-title").html()

    content: ->
      $(this).parent().find(".po-body").html()

    container: "body"
    placement: "bottom"


  $('#showPdfModal').on 'show.bs.modal', (event) ->
    button = $(event.relatedTarget)
    recipient = button.data('document')
    modal = $(this)
    modal.find('.modal-body object').attr('data', recipient)
    return

  $('[id^=collapse-]').first().addClass('in')

  fileUploadErrors =
    maxFileSize: 'File is too big'
    minFileSize: 'File is too small'
    acceptFileTypes: 'Filetype not allowed'
    maxNumberOfFiles: 'Max number of files exceeded'
    uploadedBytes: 'Uploaded bytes exceed file size'
    emptyResult: 'Empty file upload result'


  $('.fileupload-generic').fileupload()

  $('.modal').appendTo("body")

  cargar_archivos = (id) ->
    $.getJSON $('#'+id).prop('action'), (files) ->
        fu = $('#'+id).data('blueimpFileupload')
        template = undefined
        template = fu._renderDownload(files).appendTo($('#'+id+' .files'))
        # Force reflow:
        fu._reflow = fu._transition and template.length and template[0].offsetWidth
        template.addClass 'in'
        $('#loading').remove()
        return
    return


  cargar_documentos = ()->
    $('.fileupload-generic').each (indice, elemento) ->
      cargar_archivos(elemento.id)
      return
    return

  cargar_documentos()
