desc 'post author field now tied to User, update appropriately, creating new Users when needed'
task :change_blog_author_to_user => :environment do
  Post.all.each do |p|
    user = User.find_by_name(p.author)
    if user
      # we already have a user, associate post with user
      p.user = user
    else
      # need to create a new user
      chars=('a'..'z').to_a+('A'..'Z').to_a+('0'..'9').to_a;
      pw=''; 10.times{ pw += chars[rand(chars.length-1)] };
      email = p.author.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

      user = User.new(:name => p.author, :email => "#{email}@example.com", :password => pw, :password_confirmation => pw)
      begin
        if user.save
          puts "Created new user #{user.name} (#{user.id})"
        else
          puts "Failed to save new user #{user.name}: #{user.errors}"
        end
      rescue
        puts "Rescued! Failed to save new user #{user.name}"
      end

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
