Given /^I have keyword (.+)$/ do |keyword|
  AudioBook.create!(:author => 'Ladislav', :name => 'First Love')
  AudioBook.create!(:author => 'Martincik', :name => 'Second Love')
end