class ChatRequestsController < ApplicationController
  def new
    @chat_request = ChatRequest.new
  end

  def create
    @chat_request = ChatRequest.new(params[:chat_request])
    if @chat_request.save
      flash[:"alert-success"] = "Thanks! We've received your contact details and we'll be in touch soon!"
      redirect_to('/')
    else
      flash[:"alert-error"] = "You must fill all required fields."
      render 'new'
    end
  end
end
