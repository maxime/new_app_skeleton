require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do

  def mock_user_session(stubs={})
    @mock_user_session ||= mock_model(UserSession, stubs)
  end

  describe "GET new" do
    it "assigns a new user_session as @user_session" do
      user_session = mock_user_session(:user => nil)
      UserSession.stub!(:find).and_return(user_session) # for the set_current_user filter
      UserSession.stub!(:new).and_return(user_session)
      get :new
      assigns[:user_session].should equal(user_session)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created user_session as @user_session" do
        user_session = mock_user_session(:save => true, :user => nil)
        UserSession.stub!(:find).and_return(user_session) # for the set_current_user filter
        UserSession.stub!(:new).with({'these' => 'params'}).and_return(user_session)
        post :create, :user_session => {:these => 'params'}
        assigns[:user_session].should equal(user_session)
      end

      it "redirects to the homepage" do
        user_session = mock_user_session(:save => true, :user => nil)
        UserSession.stub!(:find).and_return(user_session) # for the set_current_user filter
        UserSession.stub!(:new).and_return(user_session)
        post :create, :user_session => {}
        response.should redirect_to(home_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user_session as @user_session" do
        user_session = mock_user_session(:save => false, :user => nil)
        UserSession.stub!(:find).and_return(user_session) # for the set_current_user filter

        UserSession.stub!(:new).with({'these' => 'params'}).and_return(user_session)
        post :create, :user_session => {:these => 'params'}
        assigns[:user_session].should equal(user_session)
      end

      it "re-renders the 'new' template" do
        user_session = mock_user_session(:save => false, :user => nil)
        UserSession.stub!(:find).and_return(user_session) # for the set_current_user filter
        UserSession.stub!(:new).and_return(user_session)
        post :create, :user_session => {}
        response.should render_template('new')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested user_session" do
      UserSession.stub!(:find).with(no_args) # from the set_current_user filter
      UserSession.should_receive(:find).with("37").and_return(mock_user_session)
      mock_user_session.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the homepage" do
      UserSession.stub!(:find).and_return(mock_user_session(:destroy => true, :user => nil))
      delete :destroy, :id => "1"
      response.should redirect_to(home_url)
    end
    
    it "redirects to the homepage if the user is already logged out" do
      UserSession.stub!(:find).and_return(nil)
      delete :destroy, :id => "1"
      response.should redirect_to(home_url)
    end
  end

end
