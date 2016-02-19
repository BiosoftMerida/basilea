class CreateDocumentos < ActiveRecord::Migration
  def change
    create_table :documentos do |t|
      t.string  :doc
      t.string  :nombre

      #polimorfico:
      t.integer :modelo_id
      t.string  :modelo_type

      # t.boolean :verificado , null: false , default: false
      t.timestamps
    end
    add_index :documentos, :modelo_id
  end
end
