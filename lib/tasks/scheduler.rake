desc "This task is called by the Heroku scheduler add-on"
task :update_facebook_likes => :environment do
  puts "Updating Facebook like counts for posts..."
  Post.update_facebook_likes
  puts "done."
end
