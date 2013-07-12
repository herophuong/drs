require 'spec_helper'

describe "reports/index" do
  before(:each) do
    assign(:reports, [
      stub_model(Report,
        :report_title_id => 1,
        :content => "Content",
        :fileLink => "File Link",
        :admin_user_id => 2,
        :day => 3,
        :week => 4,
        :month => 5,
        :year => 6,
        :group_id => 7
      ),
      stub_model(Report,
        :report_title_id => 1,
        :content => "Content",
        :fileLink => "File Link",
        :admin_user_id => 2,
        :day => 3,
        :week => 4,
        :month => 5,
        :year => 6,
        :group_id => 7
      )
    ])
  end

  it "renders a list of reports" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => "File Link".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
  end
end
