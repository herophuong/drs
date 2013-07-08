require "spec_helper"

describe UserMailer do
    let(:password) { "foobarfoobar" }
    let(:user) { FactoryGirl.create(:user, { password: password, password_confirmation: password} ) }
    
    describe "activated" do
        let(:mail) { UserMailer.activated(user) }
        
        it "renders the subject" do
            mail.subject.should == "Your account on DRS has been activated"
        end
        
        it "renders the receiver email" do
            mail.to.should == [user.email]
        end
        
        it "renders the login path" do
            mail.body.encoded.should match(new_admin_user_session_path)
        end
    end
end
