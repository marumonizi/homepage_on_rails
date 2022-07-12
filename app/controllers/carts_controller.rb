class CartsController < ApplicationController
  before_action :logged_in_user
  before_action :setup_cart_item!, only: [:add_item, :update_item, :delete_item]

  def index
    @cart_items = current_cart.cart_items.includes([:product])
    @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def add_item
    @cart_item ||= current_cart.cart_items.build(product_id: cart_params[:product_id])
    @cart_item.quantity += cart_params[:quantity].to_i
    if @cart_item.save
      flash[:notice] = "カートへ追加しました"
      redirect_to my_cart_url
    else
      flash[:notice] = "カートへの追加に失敗しました"
      redirect_to products_url
    end
  end

  def update_item
    if cart_params[:product_id].nil?
      flash[:notice] = "カートの更新に失敗しました"
      elsif cart_params[:quantity] == "0"
        @cart_item.destroy
        flash[:notice] = "商品を削除しました"
      elsif @cart_item.update(quantity: cart_params[:quantity].to_i)
        flash[:notice] = "カートを更新しました"
      else
        flash[:notice] = "カートの更新に失敗しました"
    end
    redirect_to my_cart_url
  end

  def delete_item
    @cart_item.destroy
    flash[:notice] = "商品を削除しました"
    redirect_to my_cart_path
  end

  private
    def setup_cart_item!
      @cart_item = current_cart.cart_items.find_by(product_id: cart_params[:product_id])
    end

    def cart_params
      params.permit(:quantity, :product_id)
    end
end