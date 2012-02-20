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

ActiveRecord::Schema.define(:version => 20120220152824) do

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

  create_table "charities", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donations", :force => true do |t|
    t.decimal  "amount",     :precision => 10, :scale => 2
    t.integer  "charity_id"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donations", ["charity_id"], :name => "index_donations_on_charity_id"
  add_index "donations", ["member_id"], :name => "index_donations_on_member_id"

  create_table "endorsements", :force => true do |t|
    t.string   "author"
    t.string   "position"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", :force => true do |t|
    t.text     "background"
    t.text     "career_plans"
    t.text     "inspiration"
    t.text     "interesting_fact"
    t.string   "location"
    t.text     "organisation_role"
    t.boolean  "confirmed",                                     :default => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "phone"
    t.boolean  "on_team",                                       :default => false
    t.integer  "team_role_id"
    t.text     "apply_occupation"
    t.text     "apply_career_plans"
    t.text     "apply_reasons_for_joining"
    t.text     "apply_heard_about_us"
    t.text     "apply_spoken_to_existing_member"
    t.string   "organisation"
    t.text     "occupation"
    t.boolean  "doing_good_inspiring",                          :default => false
    t.boolean  "doing_good_research",                           :default => false
    t.boolean  "doing_good_prophil",                            :default => false
    t.string   "external_twitter"
    t.string   "external_facebook"
    t.string   "external_linkedin"
    t.boolean  "public_profile",                                :default => true
    t.string   "real_name"
    t.string   "donation_percentage"
    t.string   "donation_average_income"
    t.string   "donation_hic_activity_hours"
    t.string   "parallel_universe_donation_percentage"
    t.string   "parallel_universe_donation_average_income"
    t.string   "parallel_universe_donation_hic_activity_hours"
    t.boolean  "doing_good_innovating"
    t.boolean  "doing_good_improving"
    t.string   "parallel_universe_occupation"
    t.datetime "contacted_date"
    t.string   "contacted_by"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_title",   :default => true
    t.boolean  "show_box",     :default => true
    t.string   "header_title"
  end

  add_index "pages", ["slug"], :name => "index_pages_on_slug", :unique => true

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "draft"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attribution"
    t.string   "slug"
    t.text     "teaser"
    t.string   "author"
    t.integer  "facebook_likes", :default => 0
  end

  add_index "posts", ["slug"], :name => "index_posts_on_slug", :unique => true

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
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
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

end
