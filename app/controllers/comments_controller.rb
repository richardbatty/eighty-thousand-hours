class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment = Comment.new( params[:comment] )
    @comment.user = current_user if current_user

    if @comment.save
      if @comment.blog_post
        BlogPostMailer.new_comment(@comment).deliver!
      else
        DiscussionPostMailer.new_comment(@comment).deliver!
      end

      render 'comments/create'
    else
      render 'comments/error'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
end
