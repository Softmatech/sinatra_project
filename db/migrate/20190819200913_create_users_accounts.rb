class CreateUsersAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :users_accounts do |uc|
      uc.string   :email
      uc.string   :password_
      uc.string   :password_repeat

      uc.timestamps
    end
  end
end
