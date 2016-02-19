class AddDocumentosRequisitosPorVistaToDocumentos < ActiveRecord::Migration
  def change
    add_reference :documentos, :documentos_requisitos_por_vista, index: true
  end

end
