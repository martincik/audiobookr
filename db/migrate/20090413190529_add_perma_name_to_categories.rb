class AddPermaNameToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :perma_name, :string
  end

  def self.down
    remove_column :categories, :perma_name
  end
end
