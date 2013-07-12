require 'spec_helper'

describe "reports/edit" do
  before(:each) do
    @report = assign(:report, stub_model(Report,
      :report_title_id => 1,
      :content => "MyString",
      :fileLink => "MyString",
      :admin_user_id => 1,
      :day => 1,
      :week => 1,
      :month => 1,
      :year => 1,
      :group_id => 1
    ))
  end

  it "renders the edit report form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => reports_path(@report), :method => "post" do
      assert_select "input#report_report_title_id", :name => "report[report_title_id]"
      assert_select "input#report_content", :name => "report[content]"
      assert_select "input#report_fileLink", :name => "report[fileLink]"
      assert_select "input#report_admin_user_id", :name => "report[admin_user_id]"
      assert_select "input#report_day", :name => "report[day]"
      assert_select "input#report_week", :name => "report[week]"
      assert_select "input#report_month", :name => "report[month]"
      assert_select "input#report_year", :name => "report[year]"
      assert_select "input#report_group_id", :name => "report[group_id]"
    end
  end
end
