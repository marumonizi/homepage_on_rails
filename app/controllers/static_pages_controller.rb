class StaticPagesController < ApplicationController
  
  def home
    @microposts = Micropost.all
    @current_user = current_user
  end

  def about
  end

  def contact
  end

  def access
  end

end
