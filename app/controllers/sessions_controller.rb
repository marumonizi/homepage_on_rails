class SessionsController < ApplicationController
  # ログインフォーム
  def new
  end

  # ログイン
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:notice] = "#{user.name}としてログインしました"
      redirect_back_or user
    else
      flash.now[:danger] = 'アカウント名又はパスワードが間違っています。'
      render 'new'
    end
  end

  # ログアウト
  def destroy
    logout if logged_in?
    flash[:notice] = 'ログアウトしました'
    redirect_to root_path
  end
end
