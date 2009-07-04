namespace :categories do
  
  desc "Generate perma name for existing categories."
  task :generate_perma_name => :environment do
    Category.all.each do |category|
      category.generate_perma_name
      category.save!
      puts "#{category.name} => #{category.perma_name}"
    end
    puts "Done."
  end
  
end