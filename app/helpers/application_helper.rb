module ApplicationHelper
  def org_name(words=false)
    if words
      "Eighty Thousand Hours"
    else
      "80,000 Hours"
    end
  end

  def format_date( date )
    date.strftime('%B') + ' ' + date.day.ordinalize + ', ' + date.strftime('%Y')
  end

  def button_link( text, path, klass = nil )
    content_tag( :div, :class => "center" ) do
      link_to  text, path, :class => (klass ? "button " + klass : "button")
    end
  end

  def markdown( text )
    text.blank? ? "" : raw(Maruku.new(text).to_html)
  end

  # To render will_paginate links with twitter bootstrap
  class BootstrapLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end

    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
    end

    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end
  end

  # To render will_paginate links with twitter bootstrap
  def page_navigation_links(pages)
    will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => BootstrapLinkRenderer, :previous_label => '&larr;'.html_safe, :next_label => '&rarr;'.html_safe)
  end

end
