class CreateEmpresas < ActiveRecord::Migration
  def change
    create_table :empresas do |t|
      t.string :nombre, null: false
      t.string :abreviado, null: false
      t.string :rif, null: false
      t.string :direccion_fiscal, null: false
      t.string :telefono, null: false
      t.references :pais, index: true

      t.timestamps
    end
    add_index :empresas, :nombre, unique: true
    add_index :empresas, :abreviado, unique: true
    add_index :empresas, :rif, unique: true
  end
end
