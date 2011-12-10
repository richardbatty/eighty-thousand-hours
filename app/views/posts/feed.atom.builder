atom_feed :language => 'en-GB' do |feed|
  feed.title @title

  @posts.each do |post|
    next if post.updated_at.blank?

    feed.entry( post ) do |entry|
      entry.title post.title

      entry.content (markdown post.body), :type => 'html'

      entry.author do |author|
        author.name post.author
      end
    end
  end
end
