class ErrorsController < ApplicationController
  def error404
    @path = params[:path]
    render "404"
  end
end
