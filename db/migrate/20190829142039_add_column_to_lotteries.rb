class AddColumnToLotteries < ActiveRecord::Migration[5.2]
  def change
    add_column :lotteries, :users_account_id, :integer
  end
end
