require File.dirname(__FILE__) + '/../spec_helper'

describe Category do
  
  before(:each) do
  end
  
  it "should create recursively categories from string" do
    category_string = "Test > SubTest > SubSubTest & name "
    category = Category.find_or_create_recursively_category_tree_from_string(category_string)
    category.name.should == "SubSubTest & name"
    category.parent.name.should == "SubTest"
    category.parent.parent.name.should == 'Test'
    category.parent.parent.parent.should be_nil
    Category.count.should == 3
  end
  
  it "should not create category if already exists" do
    category_string = "Test > SubTest > MujTest & complicated name"
    test_category = Category.create!(:name => 'Test')
    Category.create!(:name => 'SubTest', :parent => test_category)
    
    category = Category.find_or_create_recursively_category_tree_from_string(category_string)
    category.name.should == "MujTest & complicated name"
    category.parent.name.should == "SubTest"
    category.parent.parent.name.should == 'Test'
    category.parent.parent.parent.should be_nil
    Category.count.should == 3
  end
  
  it "should return array of categories as a path to root category" do
    category_string = "Test > SubTest > SubSubTest & name "
    category = Category.find_or_create_recursively_category_tree_from_string(category_string)
    category.get_path.map(&:name).should == ['Test', 'SubTest', 'SubSubTest & name']
    Category.get_path(category.id).map(&:name).should == ['Test', 'SubTest', 'SubSubTest & name']
  end
  
  it "should generate correct perma name" do
    cateogry = Category.create!(:name => 'books & audio')
    cateogry.perma_name.should == 'books-and-audio'
    cateogry = Category.create!(:name => 'books & audio:')
    cateogry.perma_name.should == 'books-and-audio'
    cateogry = Category.create!(:name => 'books_&_audio:')
    cateogry.perma_name.should == 'books-and-audio'
  end
  
  it "should provide method to find category by perma name (actually hidden id inside)" do
    category = Category.create!(:name => 'books & audio')
    Category.find_by_perma_name('books-and-audio_' + category.id.to_s).should == category
    lambda { Category.find_by_perma_name("books-and-audio_#{category.id+1}") }.should raise_error(ActiveRecord::RecordNotFound)    
  end

  it "should provide method to get perma name for URL" do
    category = Category.create!(:name => 'books & audio')
    category.url_perma_name.should == "books-and-audio_#{category.id}"
  end
  
end