require File.dirname(__FILE__) + '/../spec_helper'

describe Route, "which is given a page" do
  
  before(:each) do
    doc = Hpricot(asset_as_string('routes/normal_route.html'))
    @route = Route.new(doc)
  end
  
  it "should return five connections" do
    @route.connections.should have(5).items
  end
  
  it "should return the first connection with a start time of 14:11" do
    @route.connections.first.start_time.should == "14:11"
  end
  
  it "should return the first connection with an end time of 14:23" do
    @route.connections.first.end_time.should == "14:23"
  end
  
end
