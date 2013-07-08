require "spec_helper"

describe RegistrationMailer do
    let(:password) { "foobarfoobar" }
    let(:user) { FactoryGirl.create(:user, { password: password, password_confirmation: password} ) }

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
end
