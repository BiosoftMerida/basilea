class CreateProfesiones < ActiveRecord::Migration
  def change
    create_table :profesiones do |t|
      t.string :nombre, null:false

      t.timestamps
    end
  end
end
