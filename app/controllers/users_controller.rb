class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show] 
  before_action :correct_user,   only: [:show]
  before_action :admin_user,     only: [:index]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_mail
      redirect_to users_done_url
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
      params.require(:user).permit(:name, :password,:password_confirmation, :email)
    end

end
