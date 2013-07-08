class UserMailer < ActionMailer::Base
    default from: "drsprj@gmail.com"
    
    def activated(user)
        @user = user
        mail(to: @user.email, subject: "Your account on DRS has been activated")
    end
end
