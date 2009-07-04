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

ActiveRecord::Schema.define(:version => 20090413190529) do

  create_table "audio_book_categories", :force => true do |t|
    t.integer  "category_id",   :null => false
    t.integer  "audio_book_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "audio_books", :force => true do |t|
    t.string   "name"
    t.datetime "last_updated"
    t.string   "keywords"
    t.string   "short_description"
    t.string   "long_description"
    t.string   "sku"
    t.string   "isbn"
    t.string   "currency"
    t.decimal  "our_price",               :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "retail_price",            :precision => 10, :scale => 2, :default => 0.0
    t.string   "buy_url"
    t.string   "thumb_nail_url"
    t.string   "large_image_url"
    t.string   "sample_mwp_url"
    t.string   "sample_real_url"
    t.float    "average_customer_rating"
    t.string   "author"
    t.string   "publisher"
    t.string   "audio_length"
    t.boolean  "is_available_worldwide"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perma_name"
  end

end
