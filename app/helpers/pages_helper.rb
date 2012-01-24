module PagesHelper
  def title
    "80,000 Hours" + ( @title ? " | #{@title}" : "" )
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
end

