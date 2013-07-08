class AdminUser < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, 
            :recoverable, :rememberable, :trackable, :validatable, :registerable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me
    # attr_accessible :title, :body
    
    before_save :create_active_token
    
    state_machine :state, :initial => :inactive do
        after_transition :inactive => :active do |user, transition|
            UserMailer.activated(user).deliver
        end
        
        event :activate do
            transition :inactive => :active
        end
        
        event :deactivate do
            transition :active => :inactive
        end
        
        state :inactive, :value => 'inactive'
        state :active, :value => 'active'
    end
    
    def active_for_authentication?
        super && self.active?
    end
    
    private
        def create_active_token
            self.active_token = SecureRandom.urlsafe_base64
        end
end

