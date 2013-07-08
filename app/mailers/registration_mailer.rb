class RegistrationMailer < ActionMailer::Base
    default from: "drsprj@gmail.com"
    
    def welcome(user, password)
        @user = user
        @password = password
        
        mail(to: @user.email, subject: 'Welcome to Daily Report System')
    end
end
