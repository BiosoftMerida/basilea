class CreateContactos < ActiveRecord::Migration
  def change
    create_table :contactos do |t|
      t.string :nombres
      t.string :apellidos
      t.string :doc_identidad
      t.string :email
      t.string :telefono
      t.string :iglesia
      t.string :recomendado_por
      t.references :pais, index: true
      t.references :estado, index: true
      t.references :profesion, index: true
      t.references :ministerio, index: true
      t.references :empresa, index: true

      t.timestamps
    end
  end
end
