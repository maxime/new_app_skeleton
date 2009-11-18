require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PasswordResetsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "password_resets", :action => "index").should == "/password_resets"
    end

    it "maps #new" do
      route_for(:controller => "password_resets", :action => "new").should == "/password_resets/new"
    end

    it "maps #show" do
      route_for(:controller => "password_resets", :action => "show", :id => "1").should == "/password_resets/1"
    end

    it "maps #edit" do
      route_for(:controller => "password_resets", :action => "edit", :id => "1").should == "/password_resets/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "password_resets", :action => "create").should == {:path => "/password_resets", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "password_resets", :action => "update", :id => "1").should == {:path =>"/password_resets/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "password_resets", :action => "destroy", :id => "1").should == {:path =>"/password_resets/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/password_resets").should == {:controller => "password_resets", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/lost_password").should == {:controller => "password_resets", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/password_resets").should == {:controller => "password_resets", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/password_resets/1").should == {:controller => "password_resets", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/password_resets/1/edit").should == {:controller => "password_resets", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/password_resets/1").should == {:controller => "password_resets", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/password_resets/1").should == {:controller => "password_resets", :action => "destroy", :id => "1"}
    end
  end
end
