# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
if Rails.env.production?


else 

  first_captain = User.new(
      name:   "Warren Kushner",
      email:  "warren.kushner@gmail.com",
      password:  "TestTest",
      :avatar => Faker::Avatar.image,
      :role => "captain"
      )

  first_captain.save
   
   first_team = Team.create!(
       name: "Warren's Team",
       location: "Brazil",
       sport: "Basketball",
       :avatar => Faker::Avatar.image,
       :captain_id => first_captain.id 
     )
    first_conversation =  Conversation.create(:team_id => first_team.id)
    first_conversation.save
    first_team.save

    14.times do 
       first_teammates = User.new(
          name:   Faker::Name.name,
          email:  Faker::Internet.email,
          password:  Faker::Lorem.characters(10),
          :avatar => Faker::Avatar.image,
          :role => "teammate"
      )
       first_teammates.save
       first_team.teammates << first_teammates
       first_team.save
     end

  14.times do 
    user = User.new(
      name:   Faker::Name.name,
      email:  Faker::Internet.email,
      password:  Faker::Lorem.characters(10),
      :avatar => Faker::Avatar.image,
      :role => "captain"
      )
    user.save
   team =  Team.create!(
       name: Faker::Lorem.word,
       location: Faker::Address.city,
       sport: Faker::Lorem.word,
       :avatar => Faker::Avatar.image,
       :captain_id => user.id 
     )
     conversation =  Conversation.create(:team_id => team.id)
     conversation.save
    team.save
     
     14.times do 
       teammate = User.new(
          name:   Faker::Name.name,
          email:  Faker::Internet.email,
          password:  Faker::Lorem.characters(10),
          :avatar => Faker::Avatar.image,
          :role => "teammate"
      )
       teammate.save
       team.teammates << teammate
       team.save
     end
      
  end

  users = User.all
  teams = Team.all
  conversations = Conversation.all

   puts "Seed finished"
   puts "#{Conversation.count} users created"
   puts "#{User.count} users created"
   puts "#{Team.count} teams created"
 
 
end
