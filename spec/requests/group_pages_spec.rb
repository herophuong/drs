require 'spec_helper.rb'

describe "AdminPages" do
    let(:group) { FactoryGirl.create(:group) }
    let(:user) { FactoryGirl.create(:admin_user, group: group) }
    let(:admin) { FactoryGirl.create(:admin_user, group: FactoryGirl.create(:admin_group)) }
    
    before do
        user.activate
        admin.activate
    end
    
    subject { page }
    
    describe "Groups listing page" do        
        describe "with non-admin users" do
            before do 
                sign_in(user) 
                visit admin_groups_path
            end
            it "should not see edit and delete link on any group" do
               should_not have_link('Edit', href: edit_admin_group_path(group)) 
               should_not have_link('Delete', href: edit_admin_group_path(group))
            end
            
            it "should not access edit group page" do
                expect do
                    visit edit_admin_group_path(group)
                end.should raise_error(AbstractController::ActionNotFound)
            end
            
            it "should not see new group link" do
                should_not have_link('New Group')
            end
        end
        
        describe "with admin users" do
            before do
                sign_in(admin)
                visit admin_groups_path
            end
            
            it "should see edit link on group" do
                should have_link('Edit')
            end
            
            it "should see delete link on group" do
                should have_link('Delete', href: admin_group_path(group))
            end
            
            it "should not see delete link on current user' group" do
                should_not have_link('Delete', href: admin_group_path(admin.group))
            end
            
            it "should see new group link" do
                should have_link('New Group')
            end
            
        end
    end
end
 
