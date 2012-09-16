ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
     columns do
       column do
         panel "Recent blog posts" do
           ul do
             BlogPost.recent(15).reverse.map do |post|
               li link_to(post.title, admin_blog_post_path(post))
             end
           end
         end
       end
     end
  end # content
end
