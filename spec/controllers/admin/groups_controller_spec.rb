require 'spec_helper'

describe Admin::GroupsController do
    
    render_views
    
    let(:admin_group) { FactoryGirl.create(:admin_group) }
    let(:admin) { FactoryGirl.create(:admin_user, group: admin_group) }
    let(:group) { FactoryGirl.create(:group) }
    let(:user) { FactoryGirl.create(:admin_user, group: group) }
    
    before do
        user.activate
        admin.activate
    end
    
    describe "Non admin user" do
        before { sign_in(user) }
        
        it "can not delete any group" do
            expect{ delete :destroy, :id => admin_group.id }.should raise_error(AbstractController::ActionNotFound)
        end
    end
    
    describe "Admin user" do
        before { sign_in(admin) }
        
        it "can not delete its group" do
            expect{ delete :destroy, :id => admin_group.id }.should_not change(Group, :count)
        end
    end
end
