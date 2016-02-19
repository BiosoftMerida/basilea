class CreateEstados < ActiveRecord::Migration
  def change
    create_table :estados do |t|
      t.string :nombre, null: false
      t.string :codificacion
      t.references :pais, index: true


      t.timestamps
    end
    add_index :estados, :nombre, unique: true
  end
end
