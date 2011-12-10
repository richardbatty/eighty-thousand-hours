atom_feed :language => 'en-GB' do |feed|
  feed.title @title
  feed.updated @updated

  @posts.each do |post|
    next if post.updated_at.blank?

    feed.entry( post ) do |entry|
      entry.url post_url(post)
      entry.title post.title

      entry.content (markdown post.body), :type => 'html'

      # the strftime is needed to work with Google Reader.
      entry.updated(post.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 

      entry.author (markdown post.author), :type => 'html'
    end
  end
end
