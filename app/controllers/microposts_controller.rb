class MicropostsController < ApplicationController
  before_action :admin_user, only:[:new, :create, :destroy]
  def new
    @micropost = Micropost.new
  end

  def confirm

  end

  def create
    @micropost = current_user.microposts.new(micropost_params)
    if @micropost.save
      flash[:notice] = "投稿されました"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
  end
  
  def index
    @microposts = Micropost.page(params[:page])
  end

  def destroy
  end

  private
  
  def micropost_params
    params.require(:micropost).permit(:title, :content, :image)
  end
end
