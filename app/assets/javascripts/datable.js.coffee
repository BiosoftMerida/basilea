#= require jspdf/libs/base64.js
#= require jspdf/libs/sprintf.js
#= require jspdf/jspdf.js
#= require jquery.tablesorter.min.js
#= require tableExport.js
#= require jquery.base64.js
#= require jspdf/jspdf.debug.js
#= require jspdf/FileSaver.js
#= require jspdf/jspdf.plugin.table.js
#= require jspdf/jspdf.plugin.standard_fonts_metrics.js
#= require jquery-ui/jquery-ui.min.js
#= require dataTables/jquery.dataTables.js
#= require dataTables/dataTables.bootstrap.js
#= require dataTables/dataTables.responsive.js
#= require dataTables/dataTables.tableTools.min.js
#= require jqGrid/i18n/grid.locale-el.js
#= require jqGrid/jquery.jqGrid.min.js

jQuery(document).ready ($) ->


  $('.datatable-table').dataTable

    'dom': 'T<"clear">lfrtip'
    'tableTools':
      'sSwfPath': '../assets/dataTables/swf/copy_csv_xls_pdf.swf'
      "aButtons": [
        {
          "sExtends":     "copy",
          "sButtonText":  'Copiar &nbsp; <i class="fa fa-files-o"></i>'
        },
        {
          "sExtends":     "csv",
          "sButtonText":  'Excel &nbsp; <i class="fa fa-file-excel-o"></i>'
        },
        {
          "sExtends":         "pdf",
          "sPdfOrientation":  "landscape",
          "sButtonText":      'PDF &nbsp; <i class="fa fa-file-pdf-o"></i>'
        },
        {
          "sExtends":         "print",
          "sPdfOrientation":  "landscape",
          "sButtonText":      'Imprimir &nbsp; <i class="fa fa-print"></i>'
        },
      ]
    "language": {
      "sProcessing":    'Procesando... <i class="fa fa-spinner fa-spin"></i>',
      "sLengthMenu":    "Mostrar _MENU_ Registros",
      "sZeroRecords":   "No se encontraron resultados",
      "sEmptyTable":    "Ningún dato disponible en esta tabla",
      "sInfo":          "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
      "sInfoEmpty":     "Mostrando registros del 0 al 0 de un total de 0 registros",
      "sInfoFiltered":  "(filtrado de un total de _MAX_ registros)",
      "sInfoPostFix":   "",
      "sSearch":        '<i class="fa fa-search"></i> Buscar: ',
      "sUrl":           "",
      "sInfoThousands":  ",",
      "sLoadingRecords": 'Cargando... <i class="fa fa-spinner fa-spin"></i>',
      "oPaginate": {
        "sFirst":    "Primero",
        "sLast":    "Último",
        "sNext":    'Siguiente <i class="fa fa-angle-right"></i>',
        "sPrevious": '<i class="fa fa-angle-left"></i> Anterior'
      },
      "oAria": {
        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
      }
    }
