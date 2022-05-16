class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index] 
  before_action :correct_user,   only: [:show]
  before_action :admin_user,     only: [:index]

  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:notice] = 'アカウントが作成されました'
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :password_digest)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    def admin_user
      unless @current_user.admin?
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
