require 'spec_helper'

describe "report_titles/edit" do
  before(:each) do
    @report_title = assign(:report_title, stub_model(ReportTitle,
      :title => "MyString",
      :guide => "MyString"
    ))
  end

  it "renders the edit report_title form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => report_titles_path(@report_title), :method => "post" do
      assert_select "input#report_title_title", :name => "report_title[title]"
      assert_select "input#report_title_guide", :name => "report_title[guide]"
    end
  end
end
