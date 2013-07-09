require 'spec_helper'

# == Schema Information
#
# Table name: admin_users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  state                  :string(255)
#  manager                :boolean
#  active_token           :string(255)
#  active_token_sent_at   :datetime
#  group_id               :integer
#

describe AdminUser do
    let!(:user)  { FactoryGirl.build(:admin_user) }
    let!(:admin_group) { FactoryGirl.create(:admin_group) }
    let!(:admin) { FactoryGirl.create(:admin_user, group: admin_group) }
    
    subject { user }
    
    it { should respond_to(:active_token) }
    it { should respond_to(:active_token_sent_at) }
    it { should respond_to(:state) }
    it { should respond_to(:manager) }
    it { should respond_to(:group) }
    
    it { should be_inactive }
    it { should be_valid }
    
    it { should_not be_manager }
    
    describe "active token" do
        before { user.save }
        its(:active_token) { should_not be_blank }
    end
    
    describe "should not allow to change email after creation" do
        before do
            user.update_attributes(email: "other@framgia.com")
            user.reload
        end
        
#         its(:email) { should_not == "other@framgia.com" }
    end
    
    describe "after activated" do
        before { user.activate }
        
        it { should be_active_for_authentication }
        
        it "should send an email to notify user" do
            ActionMailer::Base.deliveries.last.to.should == [user.email]
        end
    end
    
    describe "in admin group" do
        let(:admin_group) { FactoryGirl.create(:admin_group) }
                        
        before do
            user.group = admin_group
        end
                    
        it { should be_admin }
                   
        
    end
                    
    describe "has admins method" do        
        it "list all admin users" do
            AdminUser.admins.should include(admin)
        end
    end
end
