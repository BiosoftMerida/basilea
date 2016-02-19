#= require bootstrapValidator/bootstrapValidator

jQuery(document).ready ->

$('#select_pais').change ->
    if $(this).find('option:selected').text() == 'Venezuela'
      $('#select_estado').prop( "disabled", false )
    else
      $('#select_estado').prop( "disabled", true )
      opcion: $('#select_estado').find('option:selected').text()
      opcion.prop( "text","")

$('#form_contacto').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "contacto[nombres]":
        validators:
          notEmpty:
            message: 'Debe ingresar sus nombres'
      "contacto[apellidos]":
        validators:
          notEmpty:
            message: 'Debe ingresar sus apellidos'
      "contacto[doc_identidad]":
        validators:
          notEmpty:
            message: 'Debe ingresar su nro. de documento de identidad'
      "contacto[email]":
        validators:
          notEmpty:
            message: 'Debe ingresar su cuenta de correo electrónico'
      "contacto[telefono]":
        validators:
          notEmpty:
            message: 'Debe ingresar un número de teléfono'
      "contacto[iglesia]":
        validators:
          notEmpty:
            message: 'Debe ingresar el nombre de la iglesia a la que pertenece'
      "contacto[profesion_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar su profesión'
      "contacto[ministerio_id]":
        validators:
          notEmpty:
            message: 'Debe seleccionar el ministerio que desempeña'
      "contacto[recomendado_por]":
        validators:
          notEmpty:
            message: 'Debe ingresar la persona que lo recomendó. Ej: Pastor Pedro Salinas'
