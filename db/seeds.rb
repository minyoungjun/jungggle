# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#
lan_array = ["English", "Spanish", "Vietnamese", "Chinese", "German", "Portuguese", "Japanese", "French", "Italian", "Korean", "Russian", "Malay"]
lan_array.each do |lan|
  Language.create(name: lan)
end
