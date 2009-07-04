namespace :audible do

  desc "Synchronize audio books from Audible.com"
  task :sync_all_products => :environment do
    
    all_products = File.readlines(File.join(RAILS_ROOT, 'data', 'all_products.txt'))
    imported = 0; failed = 0; not_updated = 0; count = 0
    
    all_products.each do |product_line|
      last_updated, name, category_string, keywords, short_description, long_description,
      sku, isbn, currency, our_price, retail_price, buy_url, 
      thumb_nail_url, large_image_url, 
      sample_mwp_url, sample_real_url, average_customer_rating, 
      author, publisher, audio_length, is_available_worldwide = product_line.split("\t")

      next if last_updated == 'last_updated' # Skip the first line
      
      audiobook = AudioBook.import_or_update(
        :last_updated => last_updated, :name => name,
        :category_string => category_string, :keywords => keywords,
        :short_description => short_description,
        :long_description => long_description,
        :sku => sku, :isbn => isbn, :currency => currency,
        :our_price => our_price, :retail_price => retail_price,
        :buy_url => buy_url, :thumb_nail_url => thumb_nail_url, :large_image_url => large_image_url,
        :sample_mwp_url => sample_mwp_url, :sample_real_url => sample_real_url,
        :audio_length => audio_length,
        :average_customer_rating => average_customer_rating,
        :author => author, :publisher => publisher,
        :is_available_worldwide => is_available_worldwide
      )
      
      count += 1
      if audiobook.nil?
        not_updated += 1
      elsif audiobook == false
        failed += 1
      else
        imported += 1
      end
    end
    
    puts 
    puts "Imporeted: #{imported}"
    puts "Not updated: #{not_updated}"
    puts "Failed: #{failed}"
    puts "Total: #{count}"
  end

end