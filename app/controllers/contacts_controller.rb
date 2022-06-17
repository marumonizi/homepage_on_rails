class ContactsController < ApplicationController
  # before_action :logged_in_user, only: [:show, :index, :update]
  before_action :admin_user, only: [:show, :index, :update]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      InquiryMailer.send_mail(@contact).deliver_now
      redirect_to done_path
    else
      render 'new'
    end
  end

  def done
  end

  def index
    @contacts = Contact.page(params[:page])
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(reply_params)
      @contact.update_attribute(:replyed, true)
      @contact.update_attribute(:replyed_at, Time.zone.now)
      InquiryMailer.reply_mail(@contact).deliver_now
      flash[:notice] = "#{@contact.name}様 に返信しました"
      redirect_to contacts_url
    else
      render 'show'
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message, :category)
    end

    def reply_params
      params.require(:contact).permit(:reply, :replyed, :replyed_at)
    end
end
