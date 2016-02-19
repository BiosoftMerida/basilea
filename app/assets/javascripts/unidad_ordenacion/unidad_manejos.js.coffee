#= require input-mask/jquery.inputmask.js
#= require input-mask/jquery.inputmask.regex.extensions.js
#= require jasny/jasny-bootstrap
#= require datable
#= require bootstrapValidator/bootstrapValidator
#= require lightbox/js/lightbox.min.js
#= require ubicacion_territorial

jQuery(document).ready ($) ->

  $('#form_unidad_manejo').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "unidad_manejo[bloque_ordenacion_id]":
        validators:
          notEmpty:
            message: 'El campo Cuenca es obligatorio.'
      "unidad_manejo[nombre]":
        validators:
          notEmpty:
            message: 'El campo Nombre es obligatorio.'
      "unidad_manejo[abreviado]":
        validators:
          notEmpty:
            message: 'El campo Nombre Abreviado es obligatorio.'
      "unidad_manejo[nro_providencia]":
        validators:
          notEmpty:
            message: 'El campo Número de Providencia Administrativa Abreviado es obligatorio.'
      "unidad_manejo[area]":
        validators:
          notEmpty:
            message: 'El campo Área es obligatorio.'
      "unidad_manejo[ubicacion]":
        validators:
          notEmpty:
            message: 'El campo Ubicación es obligatorio.'
      "unidad_manejo[tipo_bosque_id]":
        validators:
          notEmpty:
            message: 'El campo Tipo de Bosque es obligatorio.'