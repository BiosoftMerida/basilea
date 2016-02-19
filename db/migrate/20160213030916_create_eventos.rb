class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nombre, null: false
      t.text :descripcion, null: false
      t.date :fecha_inicio, null: false
      t.date :fecha_fin, null: false
      t.string :tlf_contacto
      t.string :email_contacto
      t.integer :cupos
      t.string :lugar
      t.string :horario
      t.decimal :precio
      t.text :servicios
      t.text :mensaje_invitacion
      t.references :empresa, index: true

      t.timestamps
    end
    add_index :eventos, :nombre, unique: true
  end
end
