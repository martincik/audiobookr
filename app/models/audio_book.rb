class AudioBook < ActiveRecord::Base

  # Relations
  has_many :audio_book_categories
  has_many :categories, :through => :audio_book_categories
  
  define_index do
    indexes :short_description
    indexes :long_description
    indexes :name
    indexes :keywords
    indexes categories.name, :as => :category_name
    indexes :isbn
    indexes :sku
    indexes :author
    indexes :publisher
  end
  
  def self.import_or_update(options={})
    categories = Category.find_or_create_recursively_from_string(options[:category_string])
    audio_book = AudioBook.find_by_name_and_author_and_publisher(options[:name], 
      options[:author], options[:publisher])
    audio_book = AudioBook.new if audio_book.nil?
    
    if audio_book.new_record? || DateTime.parse(options[:last_updated]) > audio_book.last_updated
      audio_book.last_updated = DateTime.parse(options[:last_updated])
      audio_book.name = options[:name]
      audio_book.keywords = options[:keywords]
      audio_book.short_description = options[:short_description]
      audio_book.long_description = options[:long_description]
      audio_book.sku = options[:sku]
      audio_book.isbn = options[:isbn]
      audio_book.currency = options[:currency]
      audio_book.our_price = options[:our_price].to_d
      audio_book.retail_price = options[:retail_price].to_d
      audio_book.buy_url = options[:buy_url]
      audio_book.thumb_nail_url = options[:thumb_nail_url]
      audio_book.large_image_url = options[:large_image_url]
      audio_book.sample_mwp_url = options[:sample_mwp_url]
      audio_book.sample_real_url = options[:sample_real_url]
      audio_book.audio_length = options[:audio_length]
      audio_book.average_customer_rating = options[:average_customer_rating].to_f
      audio_book.author = options[:author]
      audio_book.publisher = options[:publisher]
      audio_book.is_available_worldwide = (options[:is_available_worldwide] == 'N' ? false : true)

      audio_book.categories << categories
      audio_book.save ? audio_book : false
    else
      nil
    end
  end

end
