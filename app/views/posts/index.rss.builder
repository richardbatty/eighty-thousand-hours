xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "80,000 Hours: Blog"
    xml.description "80,000 Hours is an organisation which supports and guides people who are pursuing careers which will allow them to do the most good in the world."
    xml.link posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.getTeaser
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end
