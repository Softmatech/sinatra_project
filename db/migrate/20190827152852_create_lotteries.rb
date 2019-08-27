class CreateLotteries < ActiveRecord::Migration[5.2]
  def change
    create_table :lotteries do |l|
      l.string :name
      l.string :description
      l.string :adresse
      l.string :tel 

      l.timestamps
    end
  end
end
