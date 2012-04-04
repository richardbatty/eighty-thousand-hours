desc 'post author field now tied to User, update appropriately, creating new Users when needed'
task :change_blog_author_to_user => :environment do
  Post.all.each do |p|
    user = User.find_by_name(p.author)
    if user
      # we have a user with this name => associate post with user
      p.user = user
    end

    begin
      p.save
      puts "Saved #{p.title}"
    rescue
      puts "Failed to save #{p.title}"
    end
  end
end
