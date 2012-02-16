ActiveAdmin::Dashboards.build do
  section "Recently updated content" do
    table_for Version.order('id desc').limit(20) do
      column "Edit" do |v| link_to "Edit", v.item.admin_permalink end
      column "Title" do |v| v.item.respond_to?('title') ? v.item.title : v.item.name end
      column "Type" do |v| v.item_type.underscore.humanize end
      column "Modified at" do |v| v.created_at.to_s :long end
      column "Edited by" do |v| link_to User.find(v.whodunnit).name, admin_user_path(User.find(v.whodunnit)) end
    end
  end
end
