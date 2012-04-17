class Survey < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  def get_url_for_user( user )
    url = self.url
    url += "&#{self.name_box}=#{user.name}"
    url += "&#{self.email_box}=#{user.email}"
    url += "&#{self.id_box}=#{user.id}"

    url
  end
end
