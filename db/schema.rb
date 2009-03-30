# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090312142848) do

  create_table "abstract_lists", :force => true do |t|
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "article_list_items", :force => true do |t|
    t.text     "output"
    t.integer  "article_list_id"
    t.boolean  "is_link"
    t.string   "url"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.string   "page_file_name"
    t.string   "page_content_type"
    t.integer  "page_file_size"
    t.datetime "page_updated_at"
    t.integer  "position"
    t.integer  "article_list_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bios", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "bio"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.integer  "seo_profile_id"
  end

  create_table "contact_list_items", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "email"
    t.integer  "position"
    t.integer  "contact_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "copy_texts", :force => true do |t|
    t.text     "output"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_list_items", :force => true do |t|
    t.string   "description"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "uploaded_file_list_id"
  end

  create_table "list_items", :force => true do |t|
    t.text     "output"
    t.integer  "position"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_sections", :force => true do |t|
    t.string   "title"
    t.integer  "position"
    t.integer  "page_id"
    t.integer  "content_id"
    t.string   "content_type"
    t.boolean  "has_scroll"
    t.integer  "scroll_width"
    t.integer  "scroll_height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_title"
    t.string   "class_name"
    t.boolean  "is_vertical_scroll", :default => false
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "site_section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "seo_profile_id"
  end

  create_table "raw_htmls", :force => true do |t|
    t.text     "output"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seo_profiles", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.string   "alt_prefix"
    t.string   "heading"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "keywords"
  end

  create_table "site_sections", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "group"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
