require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ActivationsController do

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end

  describe "GET 'create'" do
    before :each do
      @user = mock_user(:active? => false,
                        :activate! => true)
      User.stub!(:find_using_perishable_token).and_return(@user)
      UserSession.stub!(:create!).and_return(true)
    end

    it "should get the user with the perishable token" do
      User.should_receive(:find_using_perishable_token).with("23019jsk", 1.week).and_return(@user)
      get :create, :activation_code => "23019jsk"
    end

    it "should redirect to homepage if the user can't be found" do
      User.stub!(:find_using_perishable_token).with("23019jsk", 1.week).and_return(nil)
      get :create, :activation_code => "23019jsk"
      response.should redirect_to(home_url)
    end

    it "should redirect to homepage if the user is already active" do
      User.stub!(:find_using_perishable_token).with("23019jsk", 1.week).and_return(@user)
      @user.stub!(:active?).and_return(true)
      get :create, :activation_code => "23019jsk"
      response.should redirect_to(home_url)
    end

    it "should activate the user" do
      @user.should_receive(:activate!).and_return(true)
      get :create, :activation_code => "23019jsk"
    end

    it "should login the user" do
      UserSession.should_receive(:create!).with(@user, false)
      get :create, :activation_code => "23019jsk"
    end

    it "should redirect to the homepage" do
      get :create, :activation_code => "23019jsk"
      response.should redirect_to(home_url)
    end

    it "should redirect to the homepage if there is a failure" do
      UserSession.stub!(:create!).and_return(false)
      get :create, :activation_code => "23019jsk"
      response.should redirect_to(home_url)
    end
  end
end
