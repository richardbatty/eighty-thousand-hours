class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment = Comment.create( params[:comment] )
    @comment.user = current_user
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
end
