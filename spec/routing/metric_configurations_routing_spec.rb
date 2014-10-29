require "rails_helper"

RSpec.describe MetricConfigurationsController, :type => :routing do
  describe "routing" do

    it "routes to #create" do
      expect(:post => "/metric_configurations").to route_to("metric_configurations#create")
    end

    it "routes to #update" do
      expect(:put => "/metric_configurations/1").to route_to("metric_configurations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/metric_configurations/1").to route_to("metric_configurations#destroy", :id => "1")
    end

    it "routes to #ranges_of" do
      expect(:get => "/metric_configurations/2/ranges_of").to route_to("metric_configurations#ranges_of", :id => "2")
    end
  end
end
