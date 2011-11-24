module InfoHelper
  def page_title
    content_tag :title do
      "80,000 Hours" + ( @title ? " - #{@title}" : "" )
    end
  end
end

