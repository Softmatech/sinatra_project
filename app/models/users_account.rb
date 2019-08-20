class Users_account < ActiveRecord::Base
    validates_presence_of :email, :password_, :password_repeat
    
end