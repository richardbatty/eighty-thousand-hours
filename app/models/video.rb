class Video
  def self.yt_session
    @yt_session ||= YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_DEV_KEY'])    
  end

  def self.all
    yt_session.videos_by(:user => 'eightythousandhours').videos
  end
end
