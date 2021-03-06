class PasswordResetsController < ApplicationController
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  def new
    render
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = t("lost_password.email_sent_notification")
      redirect_to home_url
    else
      flash[:notice] = t('lost_password.no_user_matching_email_found')
      render :action => :new
    end
  end

  def edit
    render
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.lost_password = true
    if @user.save
      flash[:notice] = t('lost_password.password_successfully_updated')
      redirect_to home_path
    else
      render :action => :edit
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:notice] = t('lost_password.invalid_url')
      redirect_to home_url
    end
  end
end
