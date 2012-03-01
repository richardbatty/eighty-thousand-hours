class Page < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  extend FriendlyId
  friendly_id :title, :use => :slugged

  belongs_to :parent,   :class_name => "Page"
  has_many   :children, :class_name => "Page", :foreign_key => 'parent_id', :order => 'menu_priority DESC'

  # for versioning with paper_trail
  has_paper_trail

  attr_accessible :title,:header_title,:body,:show_box,:just_a_link,:menu_top_level,:menu_display,:menu_priority,:parent_id

  scope :display_in_menu, where(:menu_display => true)
  scope :top_level_menu, display_in_menu.where(:menu_top_level => true).order('menu_priority DESC')

  def get_menu_link
    # link that appears in menu structures.
    # if page is 'just_a_link' then we want to link to whatever is stored in
    # body field, otherwise we link to the page slug
    "<a href='#{(just_a_link? ? body : '/'+slug)}'>#{title}</a>".html_safe
  end

  # for active admin dashboard
  def admin_permalink
    admin_page_path(self)
  end
end
