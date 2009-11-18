require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :email => "another@email.com",
      :password => "abc3832",
      :password_confirmation => "abc3832"
    }
    @user = User.new(@valid_attributes)
    @user.email = @valid_attributes[:email]
  end
  
  after :each do
    @user.destroy unless @user.nil? || @user.new_record?
  end

  it "should create a new instance given valid attributes" do
    @user.save!
  end
  
  it "should protect the email, user_type and active attributes from mass-assignment" do
    u = User.new(@valid_attributes.merge(:user_type => 1, :active => true))
    u.email.should be_nil
    u.should_not be_active
    u.user_type.should == 0
  end

  it "should have a class attribute called current_user to store the current user" do
    User.should respond_to(:current_user=)
    User.should respond_to(:current_user)
    User.current_user = @user
    User.current_user.should == @user
    User.current_user = nil
  end
  
  it "should have three different user types" do
    User::TYPES.should have(3).things
  end
  
  it "should have helpers to query the user type" do
    @user.should respond_to(:standard?)
    @user.should respond_to(:team_leader?)
    @user.should respond_to(:admin?)
  end
  
  it "should have helpers to change the user type" do
    @user.should respond_to(:become_standard)
    @user.should respond_to(:become_team_leader)
    @user.should respond_to(:become_admin) 

    @user.should be_standard
    @user.should_not be_team_leader
    @user.should_not be_admin
    
    @user.become_team_leader
    @user.should_not be_standard
    @user.should be_team_leader
    @user.should_not be_admin
    
    @user.become_admin
    @user.should_not be_standard
    @user.should_not be_team_leader
    @user.should be_admin
  end
  
  it 'should have a human user type that returns the user type in human form' do
    @user.should respond_to(:human_user_type)
    
    @user.human_user_type.should == :standard
    @user.become_team_leader
    @user.human_user_type.should == :team_leader
    @user.become_admin
    @user.human_user_type.should == :admin
  end
  
  it "should make sure the user type can't be change by the user himself" do
    User.current_user = @user
    @user.become_admin
    @user.valid?
    @user.errors.on(:user_type).should == "can't be changed by yourself"
  end
  
  it "should send an activation instructions email after create" do
    Notifier.should_receive(:deliver_activation_instructions).with(@user)
    @user.save
  end
  
  it "shouldn't be activated by default" do
    @user.should_not be_active
  end
  
  it "should provide an activate! method to activate the user" do
    @user.save
    @user.should_not be_active
    @user.activate!
    @user.reload
    @user.should be_active
  end

  it "should send an activation confirmation email after activation" do
    Notifier.should_receive(:deliver_activation_confirmation).with(@user)
    @user.save
    @user.activate!    
  end
  
  it "should make sure you can't destroy yourself" do
    @user.save
    User.stub!(:current_user).and_return(@user)
    @user.destroy
    User.exists?(@user.id).should == true
    User.stub!(:current_user).and_return(nil)
    @user.destroy
    User.exists?(@user.id).should == false
  end
  
  describe 'deliver_password_reset_instructions!' do
    it 'should reset the perishable token' do
      @user.should_receive(:reset_perishable_token!)
      Notifier.stub!(:deliver_password_reset_instructions)
      @user.deliver_password_reset_instructions!
    end

    it 'should send an email with the instructions to reset the password' do
      @user.stub!(:reset_perishable_token!)
      Notifier.should_receive(:deliver_password_reset_instructions).with(@user)
      @user.deliver_password_reset_instructions!
    end
  end
  
  describe "change password" do
    it "should validate that the current password is correct" do
      @user.save
      @user.current_password = "wrong_pass"
      @user.password = @user.password_confirmation = "new_pass"
      @user.valid?
      @user.errors.on(:current_password).should == "is incorrect"
    end

    it "should allow the change of password" do
      @user.current_password = "abc3832"
      @user.password = @user.password_confirmation = "new_pass"
      @user.should be_valid
      @user.save
      @user.valid_password?("new_pass").should == true
    end
  end
end