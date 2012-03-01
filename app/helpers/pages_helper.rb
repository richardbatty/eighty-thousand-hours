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
  def draw_menu( menu_items )
    result = ""
    if menu_items
      result += "\n<ul>\n"
      menu_items.display_in_menu.each do |c|
        result += "<li>\n\t" \
                  + c.get_menu_link \
                  + draw_menu(c.children) \
                  + "\n</li>\n"
      end
      result += "\n</ul>\n"
    end
    result.html_safe
  end
end

