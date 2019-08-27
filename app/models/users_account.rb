class UsersAccount < ActiveRecord::Base
    has_secure_password
    validates_presence_of :email, :password

    has_many :lotteries
end