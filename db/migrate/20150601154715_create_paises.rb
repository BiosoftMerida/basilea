class CreatePaises < ActiveRecord::Migration
  def change
    create_table :paises do |t|
      t.string :nombre, limit:64, null:false
      t.references :idioma, index: true
      t.timestamps
    end
    add_index :paises, :nombre, unique: true
  end
end
