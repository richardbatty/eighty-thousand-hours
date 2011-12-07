class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  # for versioning with paper_trail
  has_paper_trail
end
