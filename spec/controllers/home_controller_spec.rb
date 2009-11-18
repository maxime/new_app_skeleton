require 'spec_helper'

describe HomeController do
  describe "GET 'index'" do
    it "renders the index template" do
      get 'index'
      response.should render_template('index')
    end
    
    it "should set User.current_user to the current_user" do
      user = mock_model(User)
      controller.stub!(:current_user).and_return(user)
      User.current_user = nil
      get 'index'
      User.current_user.should == user
      User.current_user = nil
    end
  end
end
