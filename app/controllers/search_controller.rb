class SearchController < ApplicationController
  
  def index
    if params[:query].empty?
      redirect_to :action => :index and return
    end
    @audio_books = AudioBook.search params[:query], :per_page => 10, :page => params[:page]
  end
  
end
