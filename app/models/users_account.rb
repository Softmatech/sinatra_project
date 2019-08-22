class Users_account < ActiveRecord::Base
    has_secure_password
    validates_presence_of :email, :password
end