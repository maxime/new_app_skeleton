require 'spec_helper'

describe "/shared/_header.html.haml" do
  it "should have links to login or register if not logged in" do
    controller.stub!(:logged_in?).and_return false
    render
    response.should have_tag("a[href=?]", "/login", "Login")
    response.should have_tag("a[href=?]", "/sign-up", "Sign up")
  end

  it "should display 'Logged in as ..' if logged in and offers a logout link" do
    controller.stub!(:logged_in?).and_return true
    controller.stub!(:current_user).and_return mock_model(User, :email => 'email@email.com')
    render
    response.should have_text(/Logged in as\n\s+email@email.com/)
    response.should have_tag("a[href=?]", "/logout", "Logout")
  end
end
