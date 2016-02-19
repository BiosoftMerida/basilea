class CreateDocumentoRequisitos < ActiveRecord::Migration
  def change
    create_table :documento_requisitos do |t|
      t.string   :nombre, limit: 50, null: false
      t.string   :descripcion, limit: 100, null: false
      t.string   :help, limit: 100,default:nil
      t.integer  :cardinalidad_maxima, default: 1
      t.boolean  :paginado, null:false, default: false
      t.boolean  :obligatorio , null:false, default: true
      t.boolean  :almenos_uno , null:false, default: false
      t.timestamps
    end
    add_index  :documento_requisitos, :nombre, unique: true
  end
end
