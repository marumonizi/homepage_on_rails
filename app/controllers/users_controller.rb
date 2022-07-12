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
      @user.create_cart
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
      params.require(:user).permit(:name, :password,:password_confirmation)
    end

end
