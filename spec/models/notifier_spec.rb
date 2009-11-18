require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Notifier do
  describe "password_reset_instructions" do
    before(:all) do
      @user = User.new(:perishable_token => "perishable_token")
      @user.email = "email@email.com"
      @email = Notifier.create_password_reset_instructions(@user)
    end

    it "should set to be delivered to the user" do
      @email.should deliver_to("email@email.com")
    end

    it "should contain the user's message in the mail body" do
      @email.should have_text(/http:\/\/sofa-app.com\/password_resets\/perishable_token\/edit/)
    end

    it "should have the correct subject" do
      @email.should have_subject(/Password Reset Instructions/)
    end
  end
  
  describe "activation_instructions" do
    before(:all) do
      @user = User.new(:perishable_token => "perishable_token")
      @user.email = "email@email.com"
      @email = Notifier.create_activation_instructions(@user)
    end

    it "should set to be delivered to the user" do
      @email.should deliver_to("email@email.com")
    end

    it "should contain the link to activate the account" do
      @email.should have_text(/http:\/\/sofa-app.com\/activate\/perishable_token/)
    end

    it "should have the correct subject" do
      @email.should have_subject(/Activation Instructions/)
    end
  end

  describe "activation_confirmation" do
    before(:all) do
      @user = User.new(:perishable_token => "perishable_token")
      @user.email = "email@email.com"
      @email = Notifier.create_activation_confirmation(@user)
    end

    it "should set to be delivered to the user" do
      @email.should deliver_to("email@email.com")
    end

    it "should have the correct subject" do
      @email.should have_subject(/Activation Complete/)
    end
  end
  
  
end
