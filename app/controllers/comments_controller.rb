class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @comment = Comment.new( params[:comment] )
    #if params[:comment][:blog_post_id].nil?
      #@comment.discussion_post = DiscussionPost.find(params[:comment][:discussion_post_id])
    #else
      #@comment.blog_post = BlogPost.find(params[:comment][:blog_post_id])
    #end

    @comment.user = current_user if current_user
    if @comment.save
      # * Only try and send an email if a User owns the post
      # * Don't email if author commenting on their own post
      # * Only do this is a blog post
      #if !params[:comment][:blog_post_id].nil?
        #if @comment.blog_post.user && (@comment.blog_post.user != @comment.user)
          #BlogPostMailer.new_comment(@comment).deliver!
        #end
      #end

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
