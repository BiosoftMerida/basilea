class CreateInscripcionEventos < ActiveRecord::Migration
  def change
    create_table :inscripcion_eventos do |t|
      t.date :fecha
      t.string :nro_asiento
      t.date :fecha_pago
      t.string :nro_pago
      t.decimal :monto
      t.boolean :aceptado
      t.date :fecha_aceptado
      t.references :contacto, index: true
      t.references :evento, index: true

      t.timestamps
    end
  end
end
