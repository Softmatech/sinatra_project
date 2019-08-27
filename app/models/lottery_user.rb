class LotteryUser < ActiveRecord::Base

    belongs_to :users_account
    belongs_to :lottery

end 