module ApplicationHelper
  def org_name(words=false)
    if words
      "Eighty Thousand Hours"
    else
      "80,000 Hours"
    end
  end

  def button_link( text, path, klass = nil )
    content_tag( :div, :class => "center" ) do
      link_to  text, path, :class => (klass ? "button " + klass : "button")
    end
  end

  def markdown( text )
    text.blank? ? "" : raw(Maruku.new(text).to_html)
  end

  def render_menu
    begin
      menu = Page.find("menu")
      (markdown menu.body).html_safe unless menu.nil?
    rescue
      ""
    end
  end
end
