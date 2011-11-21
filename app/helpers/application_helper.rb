module ApplicationHelper
  def org_name(words=false)
    if words
      "80,000 Hours"
    else
      "Eighty Thousand Hours"
    end
  end

  def button_link( text, path, klass = nil )
    content_tag( :div, :class => "center" ) do
      link_to  text, path, :class => (klass ? "button " + klass : "button")
    end
  end
end
