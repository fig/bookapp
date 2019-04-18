require "rails_helper"

RSpec.describe KategoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/kategories").to route_to("kategories#index")
    end

    it "routes to #new" do
      expect(:get => "/kategories/new").to route_to("kategories#new")
    end

    it "routes to #show" do
      expect(:get => "/kategories/1").to route_to("kategories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/kategories/1/edit").to route_to("kategories#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/kategories").to route_to("kategories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/kategories/1").to route_to("kategories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/kategories/1").to route_to("kategories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/kategories/1").to route_to("kategories#destroy", :id => "1")
    end
  end
end
