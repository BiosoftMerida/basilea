#= require input-mask/jquery.inputmask.js
#= require input-mask/jquery.inputmask.regex.extensions.js
#= require jasny/jasny-bootstrap
#= require datable
#= require bootstrapValidator/bootstrapValidator
#= require ubicacion_territorial
#= require jquery-dynamic-selectable-unidad-ordenacion
jQuery(document).ready ($) ->

  $('select[data-dynamic-selectable-url][data-dynamic-selectable-target]').dynamicSelectable();

  $('#form_bloque_ordenacion').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "bloque_ordenacion[nombre]":
        validators:
          notEmpty:
            message: 'El campo Nombre es obligatorio.'
      "bloque_ordenacion[abreviado]":
        validators:
          notEmpty:
            message: 'El campo Nombre Abreviado es obligatorio.'
      "bloque_ordenacion[unidad_ordenacion_id]":
        validators:
          notEmpty:
            message: 'El campo Unidad de Ordenación es obligatorio.'
      "bloque_ordenacion[area]":
        validators:
          notEmpty:
            message: 'El campo Área Abreviado es obligatorio.'
          regex:
            numeric:
              message: 'Debe ser un valor numérico, decimales separados por punto.'

  $('#bloque_ordenacion_area').inputmask("Regex", {
    regex: "[0-9.]{1,9}%"
  });