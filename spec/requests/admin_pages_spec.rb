require 'spec_helper.rb'

describe "AdminPages" do
    let(:user) { FactoryGirl.create(:admin_user) }
    
    before { user.activate }
    
    subject { page }
    
    describe "Disallow login with inactive users" do
        before do
            user.deactivate
            sign_in(user)
        end
        
        it { should have_selector('title', text: 'Login') }
    end
    
    describe "Login successful with active users" do
        before { sign_in(user) }
        
        it { should have_selector('title', text: 'Dashboard') }
    end
    
    describe "Sign up new user" do
        before do
            visit new_admin_user_registration_path
            fill_in "Email", with: 'john@framgia.com'
            click_button "Sign up"
        end
        
        it "should come back to login page" do
            should have_selector('title', text: 'Login')
            should have_selector('div.flash', text: 'activated')
        end
        it "should send an email to notify user" do
            ActionMailer::Base.deliveries.last.to.should == ['john@framgia.com']
        end
    end
end
