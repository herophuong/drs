require "spec_helper"

describe ReportTitlesController do
  describe "routing" do

    it "routes to #index" do
      get("/report_titles").should route_to("report_titles#index")
    end

    it "routes to #new" do
      get("/report_titles/new").should route_to("report_titles#new")
    end

    it "routes to #show" do
      get("/report_titles/1").should route_to("report_titles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/report_titles/1/edit").should route_to("report_titles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/report_titles").should route_to("report_titles#create")
    end

    it "routes to #update" do
      put("/report_titles/1").should route_to("report_titles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/report_titles/1").should route_to("report_titles#destroy", :id => "1")
    end

  end
end
