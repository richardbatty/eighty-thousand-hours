# class ActiveAdmin::Dashboards::DashboardController
#   protected
#     
#   def find_sections
#     ActiveAdmin::Dashboards.sections_for_namespace(namespace).map
#   end
# end

ActiveAdmin::Dashboards.build do
  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.

  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end

  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end

  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # if can? :manage, Member
  #   section "Unconfirmed Members (#{Member.unconfirmed.count})" do
  #     table do
  #       Member.unconfirmed.map do |member|
  #         tr do
  #           td link_to("#{member.id}: #{member.name}", admin_member_path(member))
  #           td button_to("Confirm", confirm_admin_member_path(member), :method => :put)
  #         end
  #       end
  #     end
  #   end
  # 
  #   section "Members Without a User (dodgy)" do
  #     ul do
  #       Member.where(:user_id => nil).map do |member|
  #         li link_to(member.name, edit_admin_member_path(member))
  #       end
  #     end
  #   end
  # # end
  # 
  # section "Unpublished Posts (#{Post.draft.count})" do
  #   Post.draft.map do |post|
  #     li link_to(post.name, edit_admin_member_path(member))
  #   end
  # end
end
