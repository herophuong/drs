require "spec_helper"

describe RegistrationMailer do
    let(:password) { "foobarfoobar" }
    let(:user) { FactoryGirl.create(:admin_user, { password: password, password_confirmation: password} ) }

    describe "welcome" do
        let(:mail) { RegistrationMailer.welcome(user, password) }
        
        it "renders the subject" do
            mail.subject.should == "Welcome to Daily Report System"
        end
        
        it "renders the receiver email" do
            mail.to.should == [user.email]
        end
        
        it "should have user email in body" do
            mail.body.encoded.should match(user.email)
        end
        
        it "should have user password in body" do
            mail.body.encoded.should match(password)
        end
    end
    
    describe "notify admins" do
        let(:mail) { RegistrationMailer.notify_admins(user) }
        let!(:admin) { FactoryGirl.create(:admin_user, group: FactoryGirl.create(:admin_group)) }
        it "renders the subject" do
            mail.subject.should == "New user has signed up into Daily Report System"
        end
        
        it "renders the receiver email" do
            mail.to.should == AdminUser.admin_emails
        end
        
        it "renders the new user email" do
            mail.body.encoded.should match(user.email)
        end
    end
end
