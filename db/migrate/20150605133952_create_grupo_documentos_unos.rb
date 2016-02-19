class CreateGrupoDocumentosUnos < ActiveRecord::Migration
  def change
    create_table :grupo_documentos_unos do |t|
      t.string :mensaje, null: false, default:'',limit: 100
      t.string :icon_color, null: false, default:'',limit: 15

      t.timestamps
    end
  end
end
