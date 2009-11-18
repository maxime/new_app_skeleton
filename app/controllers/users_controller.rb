class UsersController < ApplicationController
  before_filter :require_user, :except => [:new, :create]
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :get_user, :only => [:show, :edit, :update]
  # GET /users
  # GET /users.xml
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    respond_to do |format|
      format.html # show.html.haml
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    respond_to do |format|
      format.html # edit.html.haml
    end
  end

  # POST /users
  # POST /users.xml
  def create
    email = (params[:user] ? params[:user].delete(:email) : '')
    @user = User.new(params[:user])
    @user.email = email

    respond_to do |format|
      if @user.save
        flash[:notice] = t("user.new.created")
        format.html { redirect_to(home_url) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = t("user.edit.updated")
        format.html { redirect_to(params[:id]=='current' ? user_path('current') : @user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    flash[:notice] = t("user.deleted")
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  private

  def get_user
    if params[:id] == "current"
      @user = current_user
    else
      return false if (params[:id].to_i != current_user.id)
      @user = User.find(params[:id])
    end
  end
end
