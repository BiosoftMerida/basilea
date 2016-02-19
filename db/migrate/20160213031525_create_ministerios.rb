class CreateMinisterios < ActiveRecord::Migration
  def change
    create_table :ministerios do |t|
      t.string :nombre, null: false

      t.timestamps
    end
  end
end
