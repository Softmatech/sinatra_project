class Lottery < ActiveRecord::Base
    belongs_to :users_accounts
    has_many :tirages
end