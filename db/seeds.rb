# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

14.times do 
  user = User.new(
    name:   Faker::Name.name,
    email:  Faker::Internet.email,
    password:  Faker::Lorem.characters(10),
    :avatar => Faker::Avatar.image,
    :role => "captain"
    )
  Team.create!(
     name: Faker::Lorem.word,
     location: Faker::Address.city,
     sport: Faker::Lorem.word,
     :avatar => Faker::Avatar.image,
     :captain_id => user.id 
   )
  user.save
end

users = User.all
teams = Team.all
 
 
 puts "Seed finished"
 puts "#{Team.count} teams created"
 
 
 