require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PasswordResetsController do

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end

  describe "GET new" do
    it "renders the form to input the email address" do
      get :new
      response.should render_template('new')
    end

    it "should redirect to the homepage if logged in" do
      login
      get :new
      response.should redirect_to(home_url)
    end
  end

  describe "POST create" do
    it "should get the user by email address" do
      @user = mock_user
      @user.stub!(:deliver_password_reset_instructions!)
      User.should_receive(:find_by_email).with("email@email.com").and_return(@user)
      post :create, :email => "email@email.com"
    end

    it "should deliver password reset instructions by email if the user has been found" do
      @user = mock_user
      @user.should_receive(:deliver_password_reset_instructions!).with(no_args)
      User.stub!(:find_by_email).with("email@email.com").and_return(@user)
      post :create, :email => "email@email.com"
    end

    it "should re-render the form if no user matches the email address" do
      User.stub!(:find_by_email).with("email@email.com").and_return(nil)
      post :create, :email => "email@email.com"
      response.should render_template('new')
    end

    it "should redirect to the homepage if logged in" do
      login
      get :new
      response.should redirect_to(home_url)
    end
  end

  describe "GET edit" do
    it "should get the user from the perishable code" do
      User.should_receive(:find_using_perishable_token).with("perishable_code").and_return(mock_user)
      get :edit, :id => "perishable_code"
    end

    it "should render the form to update the password if the user has been found" do
      User.stub!(:find_using_perishable_token).with("perishable_code").and_return(mock_user)
      get :edit, :id => "perishable_code"
      response.should render_template('edit')
    end

    it "should render an error if the url is invalid or expired" do
      User.stub!(:find_using_perishable_token).with("perishable_code").and_return(nil)
      get :edit, :id => "perishable_code"
      response.should redirect_to(home_url)
    end

    it "should redirect to the homepage if logged in" do
      login
      get :new
      response.should redirect_to(home_url)
    end
  end

  describe "POST update" do
    it "should get the user from the perishable code" do
      @user = mock_user
      @user.stub!(:password=)
      @user.stub!(:password_confirmation=)
      @user.stub!(:lost_password=)
      @user.stub!(:save).and_return(true)
      User.should_receive(:find_using_perishable_token).with("perishable_code").and_return(@user)
      post :update, :id => "perishable_code",
                    :user => {:password => "new_pass", :password_confirmation => "new_pass"}
    end

    it "should render an error if the url is invalid or expired" do
      User.stub!(:find_using_perishable_token).with("perishable_code").and_return(nil)
      post :update, :id => "perishable_code",
                    :user => {:password => "new_pass", :password_confirmation => "new_pass"}
      response.should redirect_to(home_url)
    end

    it "should update the user password" do
      @user = mock_user
      User.stub!(:find_using_perishable_token).with("perishable_code").and_return(@user)
      @user.should_receive(:password=).with("new_pass")
      @user.should_receive(:password_confirmation=).with("new_pass")
      @user.stub!(:lost_password=).with(true)
      @user.should_receive(:save).and_return(true)
      post :update, :id => "perishable_code",
                    :user => {:password => "new_pass", :password_confirmation => "new_pass"}
    end

    it "should login and redirect the user to the homepage if successful" do
      @user = mock_user
      User.stub!(:find_using_perishable_token).with("perishable_code").and_return(@user)
      @user.stub!(:password=).with("new_pass")
      @user.stub!(:password_confirmation=).with("new_pass")
      @user.stub!(:lost_password=).with(true)
      @user.stub!(:save).and_return(true)
      post :update, :id => "perishable_code",
                    :user => {:password => "new_pass", :password_confirmation => "new_pass"}
      response.should redirect_to(home_path)
    end

    it "should re-render the change password form if unsucessful" do
      @user = mock_user
      User.stub!(:find_using_perishable_token).with("perishable_code").and_return(@user)
      @user.stub!(:password=).with("new_pass")
      @user.stub!(:password_confirmation=).with("new_pass")
      @user.stub!(:lost_password=).with(true)
      @user.stub!(:save).and_return(false)
      post :update, :id => "perishable_code",
                    :user => {:password => "new_pass", :password_confirmation => "new_pass"}
      response.should render_template('edit')
    end

    it "should redirect to the homepage if logged in" do
      login
      get :new
      response.should redirect_to(home_url)
    end
  end
end
