module PagesHelper
  def title
    "80,000 Hours" + ( (@title.to_s == '') ? "" : " | #{@title}" )
  end

  def page_title(tag=true)
    if tag
      content_tag :title do
        title
      end
    else
      title
    end
  end

  # for each menu item (which is set to be displayed in the menu)
  # we recursively display its link and any children it has
  def draw_menu( menu_items, current_page = nil )
    result = ""
    if menu_items.size > 0
      result += "\n<ul>\n"
      menu_items.display_in_menu.each do |c|
        active = (current_page == c)
        result +=   "<li>" \
                  + c.get_menu_link(active) \
                  + draw_menu(c.children, current_page) \
                  + "</li>\n"
      end
      result += "\n</ul>\n"
    end
    result.html_safe
  end

  def draw_sidebar_menu( current_page )
    result = ""
    if current_page
      result += "<ul><li><a href='#'>blah</a></li></ul>"
    end
    result.html_safe
  end
end

