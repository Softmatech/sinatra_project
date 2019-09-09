class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |p|
      p.string :adress
      p.integer :lottery_id
    end
  end
end
