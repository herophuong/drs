require 'spec_helper'

describe Admin::AdminUsersController do
    
    render_views
    
    let(:group) { FactoryGirl.create(:group) }
    let(:user) { FactoryGirl.create(:admin_user, group: group) }
    let(:other_user) { FactoryGirl.create(:admin_user, group: group) }
    let(:admin) { FactoryGirl.create(:admin_user, group: FactoryGirl.create(:admin_group)) }
    
    before do
        user.activate
        admin.activate
    end
    
    describe "Non admin users" do
        before { sign_in(user) }
        
        describe "can not activate other user" do
            before { put :activate, :id => other_user.id }
            
            it { other_user.reload.should be_inactive }
        end
        
        describe "can not deactivate other user" do
            before do
                other_user.activate
                put :deactivate, :id => other_user.id
            end
            
            it { other_user.reload.should be_active }
        end
        
        describe "can not deactivate itself" do
            before { put :deactivate, :id => user.id }
            
            it { user.reload.should be_active }
        end
    end
    
    describe "Admin user" do
        before { sign_in(admin) }
        
        describe " - Users currently not assigned to any group" do
            let(:ungrouped_user) { FactoryGirl.create(:admin_user, group_id: nil) }
            before do
                put :activate, :id => ungrouped_user.id
            end

            it "can not be activated" do
                ungrouped_user.reload.should be_inactive
            end
        end
        
        describe " - Users previously assigned to group" do
            before do
                put :activate, :id => other_user.id
                put :deactivate, :id => user.id
            end
            
            it "can be activated" do
                user.reload.should be_inactive
            end
            it "can be deactivated" do
                other_user.reload.should be_active
            end
        end
    end
end
