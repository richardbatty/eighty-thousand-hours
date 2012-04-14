  module CommentsHelper
  def nested_comments(comments)
    comments.map do |comment, sub_comments|
      content_tag(:div, 
                  (render(comment) + content_tag(:div, 
                                                 nested_comments(sub_comments), 
                                                 :class => "nested-comments")),
                  :class => "comment", :id => "comment-#{comment.id}")
    end.join.html_safe
  end
end
