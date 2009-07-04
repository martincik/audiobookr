class CreateAudioBooks < ActiveRecord::Migration
  def self.up
    create_table :audio_books do |t|
      t.string   :name
      t.datetime :last_updated
      t.string   :keywords, :short_description, :long_description
      t.string   :sku, :isbn
      t.string   :currency
      t.decimal  :our_price, :precision => 10, :scale => 2, :default => 0
      t.decimal  :retail_price, :precision => 10, :scale => 2, :default => 0
      t.string   :buy_url # Replace [YOUR-PID] with your affiliate PID
      
      t.string   :thumb_nail_url, :large_image_url
      t.string   :sample_mwp_url, :sample_real_url
      t.float    :average_customer_rating
      
      t.string   :author, :publisher
      t.string   :audio_length
      
      t.boolean  :is_available_worldwide
      
      t.timestamps
    end
  end

  def self.down
    drop_table :audio_books
  end
end
