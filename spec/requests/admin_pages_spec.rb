require 'spec_helper.rb'

describe "AdminPages" do
    let(:user) { FactoryGirl.create(:admin_user) }
    let(:admin) { FactoryGirl.create(:admin_user, group: FactoryGirl.create(:admin_group)) }
    
    before do
        user.activate
        admin.activate
    end
    
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
            @mails = ActionMailer::Base.deliveries.last(2)
        end
        
        it "should come back to login page" do
            should have_selector('title', text: 'Login')
            should have_selector('div.flash', text: 'activated')
        end
        it "should send an email to notify user" do
            @mails.first.to.should == ['john@framgia.com']
        end
        it "should send emails to all admins" do
            @mails.last.to.should == AdminUser.admin_emails
        end
    end
    
    describe "Users listing page" do        
        describe "with non-admin users" do
            before do 
                sign_in(user) 
                visit admin_admin_users_path
            end
            it "should not see edit and delete link on other user" do
               should_not have_link('Edit', href: edit_admin_admin_user_path(admin)) 
               should_not have_link('Delete', href: edit_admin_admin_user_path(admin))
            end
            
            it "should see edit link on its self" do
                should have_link('Edit', href: edit_admin_admin_user_path(user))
            end
            
            it "should not see delete link on its self" do
                should_not have_link('Delete', href: edit_admin_admin_user_path(user))
            end
            
            it "should not see new user link" do
#                 should_not have_link('New Admin User')
            end
        end
        
        describe "with admin users" do
            before do
                sign_in(admin)
                visit admin_admin_users_path
            end
            it "should see edit link on user" do
                should have_link('Edit')
            end
            it "should see delete link on user" do
                should have_link('Delete', href: admin_admin_user_path(user))
            end
            it "should not see delete link on its self" do
                should_not have_link('Delete', href: admin_admin_user_path(admin))
            end
        end
    end
end
