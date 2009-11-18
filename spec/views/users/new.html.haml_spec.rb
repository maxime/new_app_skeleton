require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/users/new.html.haml" do
  before(:each) do
    assigns[:user] = stub_model(User,
      :new_record? => true,
      :email => "value for email",
      :password => "value for password"
    )
  end

  it "renders new user form" do
    render

    response.should have_tag("form[action=?][method=post]", users_path) do
      with_tag("input#user_email[name=?][type=?]", "user[email]", "text")
      with_tag("input#user_password[name=?][type=?]", "user[password]", "password")
      with_tag("input#user_password_confirmation[name=?][type=?]", "user[password_confirmation]", "password")
      with_tag("input[type=submit][value=?]", "Sign up")
    end
  end
end
