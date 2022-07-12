module CartsHelper
  
  def current_cart
    if current_user
      current_cart = current_user.cart || current_user.create_cart!
      session[:cart_id] ||= current_cart.id
    end
    current_cart
  end
end
