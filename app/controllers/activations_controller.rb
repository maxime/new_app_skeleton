class ActivationsController < ApplicationController
  def create
    @user = User.find_using_perishable_token(params[:activation_code], 1.week)

    if @user.nil? or @user.active?
      flash[:notice] = t("activation.error")
    end

    if @user && @user.activate! && UserSession.create!(@user, false)
      flash[:notice] = t("activation.success")
    else
      flash[:notice] = t("activation.error")
    end

    respond_to do |format|
      format.html { redirect_to home_url }
    end
  end
end
