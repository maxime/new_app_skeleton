require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSession do
  before :all do
    @valid_attributes = {
      :email => "email@email.com",
      :password => "abc3832"
    }
    
    @user_valid_attributes = {
      :email => "email@email.com",
      :password => "abc3832",
      :password_confirmation => "abc3832"
    }
      
    @user = User.new(@user_valid_attributes)
    @user.email = @user_valid_attributes[:email]
    @user.active = true
    @user.save_without_session_maintenance
  end
  
  after :all do
    @user.destroy
  end
  
  it "should be able to create a new user session with valid credentials" do
    UserSession.create!(@valid_attributes)
  end
end