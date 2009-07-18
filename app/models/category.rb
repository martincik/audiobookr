class Category < ActiveRecord::Base
  
  # Behviour
  acts_as_tree :order => "name"

  # Relations
  has_many :audio_book_categories
  has_many :audio_books, :through => :audio_book_categories
  
  # Validations
  validates_presence_of :name
  
  # Category trees
  def self.find_or_create_recursively_from_string(names_string)
    category_tree_names = names_string.split('|')
    
    category_trees = []
    category_tree_names.each do |category_tree|
      category_trees << find_or_create_recursively_category_tree_from_string(category_tree.strip)
    end
    
    category_trees
  end
  
  def self.find_or_create_recursively_category_tree_from_string(category_tree_string)
    category_names = category_tree_string.split('>')
    
    parent_category = nil
    category = nil
    for category_name in category_names
      category_name = category_name.strip
      category = Category.find_by_name(category_name)
      if category.nil?
        category = Category.create(:name => category_name, :parent => parent_category)
      end
      
      parent_category = category
    end
    
    category
  end
  
  def self.get_path(id)
    category = self.find(id)
    category.nil? ? nil : category.get_path
  end
  
  def get_path
    category = self
    path = Array.new
        
    path << category
    while !category.parent.nil?
      category = category.parent
      path << category
    end
    
    path.reverse!
  end
  
  def self.find_roots
    self.find(:all, :conditions => ['parent_id IS NULL'], :order => 'name')
  end
  
  before_create :generate_perma_name  
  def generate_perma_name
    self.perma_name = name.strip.downcase.gsub(/&/, 'and').gsub(/(\ )+|(_)+/, '-').gsub(/:/,'').gsub(/[^0-9a-z]/, '-').gsub('\-+', '-')
  end
  
  def self.find_by_perma_name(perma_name)
    pn, id = perma_name.split('_')
    Category.find(id.to_i)
  end
  
  def url_perma_name
    perma_name + '_' + id.to_s
  end
  
end
