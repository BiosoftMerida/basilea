#= require bootstrapValidator/bootstrapValidator

jQuery(document).ready ->

  $('#roles-form').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'submitted'
    fields:
      "role[name]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre para el Rol'
      'role[role_type]':
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre Tipo de Rol'