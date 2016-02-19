#= require bootstrapValidator/bootstrapValidator

jQuery(document).ready ->

  $('#form_evento').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "evento[nombre]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre'
      "evento[descripcion]":
        validators:
          notEmpty:
            message: 'Debe ingresar una descripción'
      "evento[email_contacto]":
        validators:
          notEmpty:
            message: 'Debe ingresar un e-mail de contacto'
      "evento[tlf_contacto]":
        validators:
          notEmpty:
            message: 'Debe ingresar un teléfono de contacto'
      "evento[cupos]":
        validators:
          notEmpty:
            message: 'Debe ingresar la cantidad de cupos del evento'
      "evento[lugar]":
        validators:
          notEmpty:
            message: 'Debe ingresar el lugar del evento'
      "evento[horario]":
        validators:
          notEmpty:
            message: 'Debe ingresar el horario del evento'
      "evento[mensaje_invitacion]":
        validators:
          notEmpty:
            message: 'Debe ingresar el mensaje de invitación para envío de correos'
