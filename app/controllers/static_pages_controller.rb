class StaticPagesController < ApplicationController
  
  def home
    @microposts = Micropost.all
    @products = Product.all
  end

  def about
  end

  def contact
  end

  def access
  end

  def no_exit
  end

end
