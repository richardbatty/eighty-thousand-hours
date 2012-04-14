module CommentsHelper
  def nested_comments(comments)
    comments.map do |message, sub_comments|
      render(message) + content_tag(:div, nested_comments(sub_comments), :class => "nested_comments")
    end.join.html_safe
  end
end
