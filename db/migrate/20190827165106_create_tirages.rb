class CreateTirages < ActiveRecord::Migration[5.2]
  def change
    create_table :tirages do |t|
      t.string :name
      t.string :description
      t.string :hour_tirage
    end
  end
end
