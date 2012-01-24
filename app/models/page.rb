class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  # for versioning with paper_trail
  has_paper_trail

  attr_accessible :title,:header_title,:body,:show_title,:show_box
end
