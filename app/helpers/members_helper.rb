module MembersHelper
  def member_donations(total)
    unless total == 0
      content_tag :div, id: 'donations' do
        content_tag :p, "You've donated #{number_to_currency total}."
      end
    end
  end
end
