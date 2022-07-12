class ApplicationController < ActionController::Base
  include SessionsHelper
  include CartsHelper

  private
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    def admin_user
      unless logged_in? && current_user.admin?
        store_location
        flash[:danger] = "管理用アカウントでログインしてください"
        redirect_to login_url
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless @user == current_user
    end
end
