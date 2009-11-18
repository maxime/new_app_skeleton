require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActivationsController do
  describe "route generation" do
    it "maps #create" do
      route_for(:controller => "activations", :action => "create", :activation_code => "019jsds").should ==
                                                    {:path => "/activate/019jsds", :method => :get}
    end
  end

  describe "route recognition" do
    it "generates params for #create" do
      params_from(:post, "/activate/019jsds").should == {:controller => "activations", :action => "create", :activation_code => "019jsds"}
    end
  end
end
