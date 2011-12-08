class ChatRequestsController < ApplicationController
  def new
    @chat = ChatRequest.new
  end

  def create
    @chat = ChatRequest.new(params[:chat_request])
  end
end
