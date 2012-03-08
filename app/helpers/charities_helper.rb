module CharitiesHelper
  def print_donation(d)
    "
    #{link_to d.user.name, user_path(d.user)} donated <strong>#{to_pounds(d.amount)}</strong>
    on #{d.created_at.strftime "%B %d, %Y" }".html_safe
  end
end

