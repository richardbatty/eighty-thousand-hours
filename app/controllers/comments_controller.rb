class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment = Comment.new( params[:comment] )
    @comment.post = Post.find(params[:comment][:post_id])
    @comment.user = current_user if current_user
    if @comment.save
      # let the post author know about this comment
      PostMailer.new_comment(@comment).deliver!

      render 'create'
    else
      render 'create'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
end
