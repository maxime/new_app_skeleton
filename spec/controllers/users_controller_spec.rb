require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end

  describe "being logged in" do
    before :each do
      login
    end
    
    describe "GET new" do
      it "should redirect to the homepage" do
        get :new
        response.should redirect_to(home_url)
      end
    end
  end
    
  describe "not being logged in" do
    describe "GET index" do
      it "should redirect to the login page" do
        get :index
        response.should redirect_to(login_url)
      end
    end

    describe "GET show" do
      it "should redirect to the login page" do
        get :show, :id => "37"
        response.should redirect_to(login_url)
      end
    end

    describe "GET new" do
      it "assigns a new user as @user" do
        User.stub!(:new).and_return(mock_user)
        get :new
        assigns[:user].should equal(mock_user)
      end
    end

    describe "GET edit" do
      it "should redirect to the login page" do
        get :edit, :id => "37"
        response.should redirect_to(login_url)
      end
    end

    describe "POST create" do

      describe "with valid params" do
        it "assigns a newly created user as @user" do
          User.stub!(:new).with({'these' => 'params'}).and_return(mock_user(:save => true, :email= => true))
          post :create, :user => {:these => 'params'}
          assigns[:user].should equal(mock_user)
        end
        
        it "saves the user" do
          User.stub!(:new).with({'these' => 'params'}).and_return(mock_user)
          mock_user.should_receive(:save).with(no_args).and_return(true)
          mock_user.should_receive(:email=).with('email@email.com')
          post :create, :user => {:these => 'params', :email => 'email@email.com'}
        end

        it "redirects to the homepage" do
          User.stub!(:new).with({'these' => 'params'}).and_return(mock_user(:save => true, :email= => true))
          post :create, :user => {:these => "params"}
          response.should redirect_to(home_url)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved user as @user" do
          User.stub!(:new).with({'these' => 'params'}).and_return(mock_user(:save => false, :email= => true))
          post :create, :user => {:these => 'params'}
          assigns[:user].should equal(mock_user)
        end

        it "re-renders the 'new' template" do
          User.stub!(:new).with({'these' => 'params'}).and_return(mock_user(:save => false, :email= => true))
          post :create, :user => {:these => 'params'}
          response.should render_template('new')
        end
      end

    end

    describe "PUT update" do
      it "should redirect to the login page" do
        put :update, :id => "37", :user => {:these => 'params'}
        response.should redirect_to(login_url)
      end
    end

    describe "DELETE destroy" do
      it "should redirect to the login page" do
        delete :destroy, :id => "1"
        response.should redirect_to(login_url)
      end
    end
  end # not being logged in
end
