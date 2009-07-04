class AudioBookCategory < ActiveRecord::Base
  
  belongs_to :category
  belongs_to :audio_book
  
end
