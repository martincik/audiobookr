class CategoriesController < ApplicationController
  
  def index
    @categories_tree = Category.find_roots
  end

  def show
    if params[:perma_name]
      @category = Category.find_by_perma_name(params[:perma_name])
    else
      @category = Category.find(params[:id])
    end
  end

end
