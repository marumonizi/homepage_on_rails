class ApplicationController < ActionController::Base
  include SessionsHelper
  include UsersHelper



  private
    # ログインを確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    # 管理者権限を確認
    def admin_user
      unless @current_user.admin?
        store_location
        flash[:danger] = "管理用アカウントでログインしてください"
        redirect_to login_url
      end
    end
    
    # 正しいユーザーか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless @user == current_user
    end
end
