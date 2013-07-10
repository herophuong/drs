require 'spec_helper'

describe "report_titles/index" do
  before(:each) do
    assign(:report_titles, [
      stub_model(ReportTitle,
        :title => "Title",
        :guide => "Guide"
      ),
      stub_model(ReportTitle,
        :title => "Title",
        :guide => "Guide"
      )
    ])
  end

  it "renders a list of report_titles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Guide".to_s, :count => 2
  end
end
