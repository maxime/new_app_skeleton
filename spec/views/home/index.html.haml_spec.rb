require 'spec_helper'

describe "/home/index" do
  before(:each) do
    render 'home/index'
  end
  
  it "should contain 'Home'" do
    response.should have_text(/Home/)
  end
end
