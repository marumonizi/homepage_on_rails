class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        flash[:notice] = "#{user.name}としてログインしました"
        redirect_back_or user
      else
        flash.now[:danger] = 'メールアドレス又はパスワードが間違っています。'
        render 'new'
      end
    else
      flash.now[:danger] = 'メールアドレス又はパスワードが間違っています。'
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    flash[:notice] = 'ログアウトしました'
    redirect_to root_path
  end
end
