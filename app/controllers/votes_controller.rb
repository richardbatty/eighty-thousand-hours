class VotesController < ApplicationController
  def new
    user = current_user
    type = :blog
    if params[:discussion_post]
      type = :discussion
    end

    if user
      up   = (params[:up] == 'true')

      post = ''
      user_votes = ''
      if type == :blog
        post = BlogPost.find(params[:blog_post])
        user_votes = Vote.by_blog_post(post).by_user(user)
      else
        post = DiscussionPost.find(params[:discussion_post])
        user_votes = Vote.by_discussion_post(post).by_user(user)
      end

      # check if user has already voted for this post
      if user_votes.empty?
        if type == :blog
          post.votes << Vote.new( :user => user, :blog_post => post, :positive => up )
        else
          post.votes << Vote.new( :user => user, :discussion_post => post, :positive => up )
        end
      else
        vote = user_votes.first
        if (up && vote.positive) || (!up && !vote.positive)
          # user already upvoted, and clicked up again
          # so we destroy the vote
          # and vice versa
          vote.destroy
        else
          # we had an upvote, and user clicked Down
          # so we change the upvote to a downvote
          # or vice versa
          vote.positive = !vote.positive
          vote.save
        end
      end

      @arrow_element = "#{up ? 'up-' : 'down-'}vote-#{post.id}"
      @arrow_element_other = "#{up ? 'down-' : 'up-'}vote-#{post.id}"
      @vote_element  = "total-votes-#{post.id}"
      @net_votes = post.net_votes
    else
      @error_element = "vote-error-#{post.id}"
      @error = "NO!"
    end

    respond_to do |format|
      format.js { render :layout => false }
    end
  end
end
