module InfoHelper
  def page_title
    content_tag :title do
      "High Impact Careers" + ( @title ? " - #{@title}" : "" )
    end
  end
end
