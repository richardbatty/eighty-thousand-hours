class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment = Comment.new( params[:comment] )
    if params[:comment][:post_id].empty?
      @comment.discussion_post = DiscussionPost.find(params[:comment][:discussion_post_id])
    else
      @comment.post = Post.find(params[:comment][:post_id])
    end

    @comment.user = current_user if current_user
    if @comment.save
      # * Only try and send an email if a User owns the post
      # * Don't email if author commenting on their own post
      # * Only do this is a blog post
      if !params[:comment][:post_id].empty?
        if @comment.post.user && (@comment.post.user != @comment.user)
          PostMailer.new_comment(@comment).deliver!
        end
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
