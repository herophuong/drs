# == Schema Information
#
# Table name: groups
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  admin      :boolean
#

require 'spec_helper'

describe Group do
    let(:group) { FactoryGirl.build(:group) }
    subject { group }
    
    it { should respond_to(:admin_users) }
    it { should respond_to(:name) }
    it { should respond_to(:admin) }
    it { should be_valid }
        
    it { should_not be_admin }
    
    describe "with same name" do
        let(:another_group) { FactoryGirl.create(:group) }
        before do
        group.name = another_group.name.upcase
        end
        it { should_not be_valid }
    end
    describe "with blank name" do
        before { group.name = " " }
        it { should_not be_valid }
    end
    describe "users association" do
        let(:new_group) { FactoryGirl.create(:group) }
        let(:user) { FactoryGirl.create(:admin_user, group_id: new_group.id) }
        it "should include user" do
           new_group.admin_users.should include(user)
        end
    end
end
