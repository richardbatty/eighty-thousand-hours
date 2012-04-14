class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @comment = Comment.new(parent_id: params[:parent_id], post_id: params[:post_id])
  end

  def create
    @comment = Comment.create( params[:comment] )
    @comment.user = current_user
    @comment.save
  end
end
