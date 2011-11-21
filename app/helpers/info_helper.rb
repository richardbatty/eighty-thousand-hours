module InfoHelper
  def page_title
    content_tag :title do
      "Eighty Thousand Hours" + ( @title ? " - #{@title}" : "" )
    end
  end
end

