# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120916202218) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.string   "namespace"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "attached_images", :force => true do |t|
    t.integer  "blog_post_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_posts", :id => false, :force => true do |t|
    t.integer  "id",                                       :null => false
    t.string   "title"
    t.text     "body"
    t.boolean  "draft",          :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attribution"
    t.string   "slug"
    t.text     "teaser"
    t.string   "author"
    t.integer  "facebook_likes", :default => 0
    t.integer  "user_id"
    t.string   "category",       :default => "discussion"
  end

  add_index "blog_posts", ["slug"], :name => "index_posts_on_slug", :unique => true

  create_table "causes", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.text     "description"
  end

  add_index "causes", ["slug"], :name => "index_charities_on_slug", :unique => true

  create_table "comments", :force => true do |t|
    t.integer  "blog_post_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "email"
    t.integer  "discussion_post_id"
  end

  create_table "discussion_posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "draft",      :default => false
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "discussion_posts", ["slug"], :name => "index_discussion_posts_on_slug", :unique => true

  create_table "donations", :force => true do |t|
    t.integer  "amount_cents",         :default => 0
    t.integer  "cause_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "receipt_file_name"
    t.string   "receipt_content_type"
    t.integer  "receipt_file_size"
    t.datetime "receipt_updated_at"
    t.boolean  "confirmed",            :default => false
    t.boolean  "public",               :default => true
    t.boolean  "public_amount",        :default => false
    t.date     "date"
    t.string   "currency"
  end

  add_index "donations", ["cause_id"], :name => "index_donations_on_charity_id"
  add_index "donations", ["user_id"], :name => "index_donations_on_user_id"

  create_table "endorsements", :force => true do |t|
    t.string   "author"
    t.string   "position"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "header",           :default => false
    t.boolean  "endorsement_page", :default => true
    t.integer  "weight",           :default => 1
  end

  create_table "etkh_profiles", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "inspiration"
    t.text     "interesting_fact"
    t.text     "background"
    t.text     "career_plans"
    t.text     "occupation"
    t.text     "organisation_role"
    t.string   "organisation"
    t.boolean  "public_profile",             :default => true
    t.datetime "contacted_date"
    t.string   "contacted_by"
    t.boolean  "confirmed",                  :default => false
    t.text     "skills_knowledge_share"
    t.text     "skills_knowledge_learn"
    t.integer  "user_id"
    t.text     "causes_comment"
    t.text     "activities_comment"
    t.integer  "donation_percentage",        :default => 30
    t.boolean  "donation_percentage_optout", :default => false
  end

  create_table "etkh_profiles_profile_option_activities", :id => false, :force => true do |t|
    t.integer "etkh_profile_id"
    t.integer "profile_option_activity_id"
  end

  create_table "etkh_profiles_profile_option_causes", :id => false, :force => true do |t|
    t.integer "etkh_profile_id"
    t.integer "profile_option_cause_id"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_box",               :default => true
    t.string   "header_title"
    t.boolean  "menu_top_level",         :default => false
    t.boolean  "menu_display",           :default => true
    t.integer  "menu_priority",          :default => 0
    t.boolean  "just_a_link",            :default => false
    t.integer  "parent_id"
    t.boolean  "menu_display_in_footer", :default => true
    t.boolean  "menu_sidebar",           :default => false
  end

  add_index "pages", ["slug"], :name => "index_pages_on_slug", :unique => true

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "draft",          :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attribution"
    t.string   "slug"
    t.text     "teaser"
    t.string   "author"
    t.integer  "facebook_likes", :default => 0
    t.integer  "user_id"
    t.string   "category",       :default => "discussion"
  end

  create_table "profile_option_activities", :force => true do |t|
    t.string "title"
  end

  create_table "profile_option_causes", :force => true do |t|
    t.string "title"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "supporters", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "dont_email_me"
    t.boolean  "anonymous"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supporters", ["email"], :name => "index_supporters_on_email", :unique => true

  create_table "surveys", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "url"
    t.string   "name_box"
    t.string   "email_box"
    t.string   "id_box"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "surveys", ["slug"], :name => "index_surveys_on_slug", :unique => true

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "team_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "slug"
    t.string   "location"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "phone"
    t.boolean  "on_team",                               :default => false
    t.integer  "team_role_id"
    t.string   "external_twitter"
    t.string   "external_facebook"
    t.string   "external_linkedin"
    t.string   "real_name"
    t.string   "external_website"
    t.boolean  "omniauth_signup",                       :default => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "blog_post_id"
    t.boolean  "positive"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
