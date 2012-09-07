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
  #def draw_menu( menu_items, current_page = nil, outer_tag = "ul", inner_tag = "li" )
  #  result = ""
  #  if menu_items.size > 0
  #    result += "\n<#{outer_tag}>\n"
  #    menu_items.display_in_menu.each do |c|
  #      active = (current_page == c)
  #      result +=   "<#{inner_tag}>" \
  #                + c.get_menu_link(active) \
  #                + draw_menu(c.children, current_page, outer_tag, inner_tag) \
  #                + "</#{inner_tag}>\n"
  #    end
  #    result += "\n</#{outer_tag}>\n"
  #  end
  #  result.html_safe
  #end

  # crippled version of previous recursive function
  # we draw top level items and any children but that's it
  def draw_menu( top_level_items, current_page = nil )
    result = "
    <div class='navbar navbar-menu navbar-inverse'>
    <div class='navbar-inner'>
    <div class='container'>
    <ul class='nav'>"
    top_level_items.each do |t|
      active = (@menu_root == t.title)
      if t.children.size > 0
        result += "<li class='dropdown #{ active ? "active" : "" } top-level' >"
        result += "
        <a href='#' class='dropdown-toggle top-level' data-toggle='dropdown'>
          #{t.title} <b class='caret'></b>
        </a>
        <ul class='dropdown-menu'>"
        result += "<li>#{t.get_menu_link(active)}</li>"
        result += "<li class='divider'></li>"

        t.children.each do |c| 
          active = (@menu_current == c.title)
          result += "<li #{ active ? "class='active'" : ""}>#{c.get_menu_link(active)}</li>"
        end

        result += "</ul>"
        result += "</li>"
      else 
        result += "<li class='#{ active ? "active" : "" } top-level'>#{t.get_menu_link("top-level active #{active ? 'active' : ''} top-level")}</li>"
      end
      result += "</li>"
      result += "<li class='divider-vertical'></li>"
    end

    result += "
    </ul>

    <form class='navbar-search' action='/search' method='get'>
      <input class='search-query' name='q' placeholder='search...' type='text' />
    </form>
    </div>
    </div>
    </div>"
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

