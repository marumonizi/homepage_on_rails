module SessionsHelper

  # セッションにidを記録
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログインしているユーザー
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # 現在ログインしているユーザーか判別
  def current_user?(user)
    user = current_user
  end

  # ログインしているかどうか
  def logged_in?
    !current_user.nil?
  end

  # セッションのidを消してログアウト
  def logout
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # デフォルトがなければ１つ前の画面に戻る
  def redirect_back_or(default)
    redirect_to session[:forwarding_url] || default
    session.delete(:forwarding_url)
  end

  # リクエスト元を記憶
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  # 永続的セッションを記憶
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 永続的セッションを記憶を破棄
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

end
