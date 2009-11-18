Given /^I am not register to the website$/ do
  User.destroy_all
end

Given /^I am already registered with the email address "([^\"]*)"$/ do |email|
  u = User.new(:password => "blabla", :password_confirmation => "blabla")
  u.email = email
  u.active = true
  u.save
end
