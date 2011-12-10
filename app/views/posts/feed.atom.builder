atom_feed :language => 'en-GB' do |feed|
  feed.title @title
  feed.updated @updated

  @posts.each do |post|
    next if post.updated_at.blank?

    feed.entry( post ) do |entry|
      entry.title post.title

      entry.content (markdown post.body), :type => 'html'

      # formatting needed for Google Reader
      entry.updated(post.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 

      entry.author do |author|
        author.name post.author
      end
    end
  end
end
