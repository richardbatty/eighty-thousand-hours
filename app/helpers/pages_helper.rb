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
  def draw_menu( menu_items, current_page = nil, outer_tag = "ul", inner_tag = "li" )
    result = ""
    if menu_items.size > 0
      result += "\n<#{outer_tag}>\n"
      menu_items.display_in_menu.each do |c|
        active = (current_page == c)
        result +=   "<#{inner_tag}>" \
                  + c.get_menu_link(active) \
                  + draw_menu(c.children, current_page, outer_tag, inner_tag) \
                  + "</#{inner_tag}>\n"
      end
      result += "\n</#{outer_tag}>\n"
    end
    result.html_safe
  end

  def draw_footer_menu
    result = ""
    menu_items = Page.top_level_menu_footer
    if menu_items.size > 0
      menu_items.display_in_menu_footer.each do |c|
        result +=   "<ul>"\
                  + "<li class='heading'>"+c.get_menu_link+"</li>"
        c.children.display_in_menu_footer.each do |d|
          result += "<li>"+d.get_menu_link+"</li>"
        end
        result += "</ul>\n"
      end
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

