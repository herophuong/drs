require 'spec_helper'

describe "report_titles/show" do
  before(:each) do
    @report_title = assign(:report_title, stub_model(ReportTitle,
      :title => "Title",
      :guide => "Guide"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Guide/)
  end
end
