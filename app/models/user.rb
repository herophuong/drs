class User < ActiveRecord::Base
  attr_accessible :active_token, :email, :manager, :name, :password_digest, :state
end
