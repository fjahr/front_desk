class ContactsController < ApplicationController
  protect_from_forgery with: :exception

  def new
    @contact = Contact.new

    case params[:subject]
    when "phone"
      @contact.subject = "Chat + Phone plan"
      @contact.message = "Please notify me when the Chat + Phone plan is available"
    when "enterprise"
      @contact.subject = "Enterprise plan"
    end
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
      render :new
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message, :captcha)
  end
end
