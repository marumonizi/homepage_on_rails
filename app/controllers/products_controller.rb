class ProductsController < ApplicationController
  before_action :admin_user, only:[:new, :create, :update, :destroy]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = "商品を登録しました"
      redirect_to products_path
    else
      render 'new'
    end
  end

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @cart = current_cart
  end
  
  def update
    
  end

  def destroy

  end

  private
    def product_params
      params.require(:product).permit(:name, :price, :introduction, {images: []})
    end
end
