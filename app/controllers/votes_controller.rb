class VotesController < ApplicationController
  def new
    user = current_user
    post = BlogPost.find(params[:blog_post])

    if user
      up   = (params[:up] == 'true')
      user_votes = Vote.by_blog_post(post).by_user(user)

      # check if user has already voted for this post
      if user_votes.empty?
        post.votes << Vote.new( :user => user, :blog_post => post, :positive => up )
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
