class CreateLotteryUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :lottery_users do |lu|
      lu.integer :users_account_id
      lu.integer :lottery_id
    end
  end
end
