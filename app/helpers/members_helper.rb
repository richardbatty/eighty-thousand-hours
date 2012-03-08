module MembersHelper
  def member_donation_full(d)
    "<strong>#{to_pounds(d.amount)}</strong>
    to #{link_to d.charity.name, charity_path(d.charity)}
    on #{d.created_at.strftime "%B %d, %Y" }".html_safe
  end
end
