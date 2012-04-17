class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment = Comment.new( params[:comment] )
    @comment.post = Post.find(params[:comment][:post_id])
    @comment.user = current_user if current_user
    if @comment.save
      # only try and send an email if a User owns the post
      # and don't email if author commenting on their own post
      if @comment.post.user && (@comment.post.user != @comment.user)
        PostMailer.new_comment(@comment).deliver!
      end

      render 'create'
    else
      render 'error'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
end
