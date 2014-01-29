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

ActiveRecord::Schema.define(:version => 20140128232055) do

  create_table "allergies", :force => true do |t|
    t.string "yummly_id"
    t.string "name"
    t.string "yummly_code"
  end

  create_table "diets", :force => true do |t|
    t.string "yummly_id"
    t.string "name"
    t.string "yummly_code"
  end

  create_table "keys", :force => true do |t|
    t.string "application_id"
    t.string "application_keys"
  end

  create_table "recipes", :force => true do |t|
    t.string  "name"
    t.string  "total_time"
    t.integer "seconds"
    t.string  "source_url"
    t.string  "servings"
    t.string  "image_url"
    t.string  "yummly_id"
    t.string  "ingredient_list", :default => "--- []\n"
  end

end
