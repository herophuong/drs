require "spec_helper"

describe ReportMailer do
  describe "notify admins" do
        let(:mail) { ReportMailer.notify_managers }
        let!(:manager) { FactoryGirl.create(:user_manager, group: FactoryGirl.create(:group))} 
        it "renders the subject" do
            mail.subject.should == "You are manager"
        end
        
        it "renders the receiver email" do
            mail.to.should == [manager.email]
        end
    end
end
