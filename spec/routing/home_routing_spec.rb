require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HomeController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "home", :action => "index").should == "/"
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/").should == {:controller => "home", :action => "index"}
    end
  end
end
