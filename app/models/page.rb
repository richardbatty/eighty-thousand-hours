class Page < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  extend FriendlyId
  friendly_id :title, :use => :slugged

  # for versioning with paper_trail
  has_paper_trail

  attr_accessible :title,:header_title,:body,:show_title,:show_box

  # for active admin dashboard
  def admin_permalink
    admin_page_path(self)
  end
end
