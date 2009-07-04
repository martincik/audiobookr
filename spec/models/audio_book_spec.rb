require File.dirname(__FILE__) + '/../spec_helper'

module AudioBookSpecHelper
  
  def example_audiobook_data
    {
      :last_updated => 'Apr 01, 2009', :name => "Special Miracles at Journey's End (Unabridged)",
      :category_string => "Kids & Young Adults > Animal Stories, Kids & Young Adults > Classics", 
      :keywords => "firstkey secondkey",
      :short_description => "Short description",
      :long_description => "Long desciption",
      :sku => "sku", :isbn => "isbn", :currency => "USD",
      :our_price => "1.99", :retail_price => "1.50",
      :buy_url => "http://www.qksrv.net/click-[YOUR-PID]-10273919?url=http%3A%2F%2Fwww.audible.com%2Fadbl%2Fstore%2FCJProduct.jsp%3FproductID%3DBK_HARP_001679", 
      :thumb_nail_url => "http://img.audible.com/audiblewords/content/bk/harp/001679/small_frame.gif", 
      :large_image_url => "http://img.audible.com/audiblewords/content/bk/harp/001679/full_image.jpg",
      :sample_mwp_url => "http://cdl.audible.com/cgi-bin/aw_streamer.pl?prod_id=BK_HARP_001679&amp;format=asf", 
      :sample_real_url => "http://cdl.audible.com/cgi-bin/aw_streamer.pl?prod_id=BK_HARP_001679&format=rm",
      :audio_length => "6 min.",
      :average_customer_rating => "0",
      :author => "Sarah Weeks", :publisher => "Harper Audio",
      :is_available_worldwide => "N"
    }
  end
  
end

describe AudioBook do
  include AudioBookSpecHelper
  
  before(:each) do
  end
  
  it "should correctly import audio book info with categories" do
    audio_book = AudioBook.import_or_update(example_audiobook_data)
    audio_book.should be_instance_of(AudioBook)
    audio_book.categories.count.should == 2
    Category.all.map(&:name).should == ["Kids & Young Adults", "Animal Stories", "Classics"]
    audio_book.categories.first.get_path.map(&:name).should == ["Kids & Young Adults", "Animal Stories"]
    audio_book.categories.last.get_path.map(&:name).should == ["Kids & Young Adults", "Classics"]
    audio_book.last_updated.should == Date.civil(2009, 4, 1)
    audio_book.name.should == example_audiobook_data[:name]
    audio_book.keywords.should == example_audiobook_data[:keywords]
    audio_book.short_description.should == example_audiobook_data[:short_description]
    audio_book.long_description.should == example_audiobook_data[:long_description]
    audio_book.sku.should == example_audiobook_data[:sku]
    audio_book.isbn.should == example_audiobook_data[:isbn]
    audio_book.currency.should == example_audiobook_data[:currency]
    audio_book.our_price.should == BigDecimal.new("1.99")
    audio_book.retail_price.should == BigDecimal.new("1.5")
    audio_book.buy_url.should == "http://www.qksrv.net/click-[YOUR-PID]-10273919?url=http%3A%2F%2Fwww.audible.com%2Fadbl%2Fstore%2FCJProduct.jsp%3FproductID%3DBK_HARP_001679"
    audio_book.thumb_nail_url.should == "http://img.audible.com/audiblewords/content/bk/harp/001679/small_frame.gif" 
    audio_book.large_image_url.should == "http://img.audible.com/audiblewords/content/bk/harp/001679/full_image.jpg"
    audio_book.sample_mwp_url.should == "http://cdl.audible.com/cgi-bin/aw_streamer.pl?prod_id=BK_HARP_001679&amp;format=asf"
    audio_book.sample_real_url.should == "http://cdl.audible.com/cgi-bin/aw_streamer.pl?prod_id=BK_HARP_001679&format=rm"
    audio_book.audio_length.should == "6 min."
    audio_book.average_customer_rating.should == 0
    audio_book.author.should == "Sarah Weeks"
    audio_book.publisher.should == "Harper Audio"
    audio_book.is_available_worldwide.should == false
  end
  
  it "should add new audio books if not in db" do
    AudioBook.count.should == 0
    data = example_audiobook_data
    audio_book = AudioBook.import_or_update(data)
    AudioBook.count.should == 1
    data[:name] = 'Test'
    audio_book = AudioBook.import_or_update(data)
    AudioBook.count.should == 2
  end
  
  it "should not update anything if there's nothing to change" do
    AudioBook.count.should == 0
    audio_book = AudioBook.import_or_update(example_audiobook_data)
    audio_book.should be_instance_of(AudioBook)
    AudioBook.count.should == 1    
    audio_book = AudioBook.import_or_update(example_audiobook_data)
    audio_book.should be_nil
    AudioBook.count.should == 1
  end
  
  it "should update the audio book if last_updated changed and is higher than in db" do
    AudioBook.count.should == 0
    data = example_audiobook_data
    audio_book = AudioBook.import_or_update(data)
    audio_book.should be_instance_of(AudioBook)
    AudioBook.count.should == 1    
    data[:last_updated] = "Apr 04, 2009"
    audio_book = AudioBook.import_or_update(data)
    audio_book.should be_instance_of(AudioBook)
    AudioBook.count.should == 1    
  end

end