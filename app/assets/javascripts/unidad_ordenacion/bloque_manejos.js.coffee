#= require datable
#= require bootstrapValidator/bootstrapValidator
#= require input-mask/jquery.inputmask.js
#= require input-mask/jquery.inputmask.regex.extensions.js
#= require cocoon

jQuery(document).ready ($) ->

  $('#form_bloque_manejo').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "bloque_manejo[codigo]":
        validators:
          notEmpty:
            message: 'El campo Número de Bloque es obligatorio.'
      "bloque_manejo[area]":
        validators:
          notEmpty:
            message: 'El campo Área es obligatorio.'

  $('#bloque_manejo_area').inputmask("Regex", {
    regex: "[0-9.]{1,9}%"
  });