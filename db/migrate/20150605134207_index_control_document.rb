class IndexControlDocument < ActiveRecord::Migration
  add_index :documentos , [:doc,
                           :modelo_id,
                           :modelo_type,
                           :documentos_requisitos_por_vista_id],
            unique: true, name: 'index_control_documentos'
end
