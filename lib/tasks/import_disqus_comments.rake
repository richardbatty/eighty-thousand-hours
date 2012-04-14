require "rexml/document"
desc 'import Disqus comments into 80k db'
task :import_disqus_comments => :environment do
  xml = File.read("#{Rails.root}/public/disqus.xml")
  doc, threads = REXML::Document.new(xml), []
  # put all threads in a hash
  threads = {}
  doc.each_element("disqus/thread") do |thread|
    id = thread.elements.to_a("id").first.text
    title = thread.elements.to_a("title").first.text
    threads[thread.attributes["dsq:id"]] = { id: id, title: title }
  end
  
  # iterate over all comments
  doc.each_element("disqus/post") do |post|
    msg       = post.elements["message"].text
    date      = post.elements["createdAt"].text
    thread_id = post.elements["thread"].attributes["dsq:id"]
    name      = post.elements["author"].elements["name"].text
    email     = post.elements["author"].elements["email"].text
  
    #puts threads[thread_id]
    #puts thread_id
    #puts msg
    #puts name
    #puts email
    #puts date
  

    p = Post.find(threads[thread_id][:id].split('-').last.to_i)
    if p.nil?
      puts "Couldn't find post #{threads[thread_id][:title]} ... not saving comment"
    else
      puts "Adding comment to post #{threads[thread_id][:title]}"
      u = User.find_by_email(email)
      if u.nil?
        u = User.find_by_name(name)
      end

      if u.nil?
        puts "\tCouldn't find user #{email} (#{name}) ... creating comment without user"
        if name.nil? || name.strip.empty?
          name = "Anonymous"
        end
        if email.nil? || email.strip.empty?
          email = "anon@example.com"
        end
        c = Comment.new(post_id: p.id, body: msg, name: name, email: email)
        c.save
        c.created_at = date
        c.save
      else
        puts "\tFound user #{email} (#{name}): #{u.id}[#{u.name},#{u.email}]"
        c = Comment.new(post_id: p.id, body: msg, user_id: u.id)
        c.save
        c.created_at = date
        c.save
      end
    end
  end
end
