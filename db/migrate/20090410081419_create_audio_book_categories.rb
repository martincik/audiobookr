class CreateAudioBookCategories < ActiveRecord::Migration
  def self.up
    create_table :audio_book_categories do |t|
      t.integer :category_id, :null => false
      t.integer :audio_book_id, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :audio_book_categories
  end
end
