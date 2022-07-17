class AcountActivationsController < ApplicationController
  
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      redirect_to users_done_url
    else
      redirect_to acount_activation_resend_url
    end
  end

  def resend
  end
end
