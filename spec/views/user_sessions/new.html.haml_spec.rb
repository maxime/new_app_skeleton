require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/user_sessions/new.html.haml" do
  before(:each) do
    assigns[:user_session] = UserSession.new
  end

  it "renders new user_session form" do
    render

    response.capture(:banner).should have_tag("form[action=?][method=post]", user_sessions_path) do
      with_tag("input#user_session_email[name=?]", "user_session[email]")
      with_tag("input#user_session_password[name=?][type=?]", "user_session[password]", "password")
      with_tag("input[type=submit][value=?]", "Login")
    end
  end
end
