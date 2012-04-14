class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @comment = Comment.new(:parent_id => params[:parent_id])
  end

  def create
    @comment = Comment.create( params[:comment] )
    @comment.user = current_user

    if @comment.save
      flash[:"alert-success"] = "Comment posted successfully"
      redirect_to post_path( @comment.post )
    else
      render 'new'
    end
  end
end
