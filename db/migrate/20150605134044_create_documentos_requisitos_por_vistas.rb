class CreateDocumentosRequisitosPorVistas < ActiveRecord::Migration
  def change
    create_table :documentos_requisitos_por_vistas do |t|
      t.references :documento_requisito
      t.references :vista
      t.references :grupo_documentos_uno
      t.timestamps
    end
    add_index :documentos_requisitos_por_vistas, :documento_requisito_id, name: 'index_doc_requisito_intermedia'
    add_index :documentos_requisitos_por_vistas, :vista_id, name: 'index_vista_intermedia'
    add_index :documentos_requisitos_por_vistas, :grupo_documentos_uno_id, name: 'index_grupo_documentos_uno_intermedia'

    add_index :documentos_requisitos_por_vistas, [:documento_requisito_id,:vista_id],
              unique: true, name: 'index_documentos_unique_vista'
  end
end
