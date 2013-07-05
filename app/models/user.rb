# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  active_token    :string(255)
#  state           :string(255)
#  manager         :boolean
#  password_digest :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class User < ActiveRecord::Base
    attr_accessible :email, :name, :password, :password_confirmation
    
    has_secure_password
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[Ff][Rr][Aa][Mm][Gg][Ii][Aa]\.[Cc][Oo][Mm]/
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 6 }, presence: true, on: :create
    validates :password_confirmation, presence: true, on: :create
    
    before_save { self.email.downcase! }
    
    state_machine :state, :initial => :inactive do
       event :activate do
           transition :inactive => :active
       end
       
       event :deactivate do
           transition :active => :inactive
       end
       
       state :inactive, :value => 0
       state :active, :value => 1
    end
end
