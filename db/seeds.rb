# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
if Rails.env.production?
  questions = ["What country does this story orginate? (Japan)",
    "Think about your life as it is right now. There's a lot going on huh? Now think about the single most exciting possibility you can accomplish over the next five years. What is it?",
    "What is your favorite animal?",
    "Who in your life has helped you like the boy? What did they do?",
    "The girl in the video loves her father. Who do you love?",
    "The world is a big place, full of beauty and wonder. What is one place you would like to visit?, Why?",
    "Which is your favorite Albert Einstein quote?, Why?",
    "Which quote inspires you the most?, Why?"]
    # IMPORTANT! add s in front of https otherwise video will not rendor
    # IMPORTANT! for all youtube videos use embeded urls

  videos = [
      "https://www.youtube.com/embed/IGMW6YWjMxw",
      "https://www.youtube.com/embed/EdQ5HT0LK8g",
      "https://www.youtube.com/embed/4B_RDrGdINY?list=PLdMisKontG3gHkeGlECyYfgt62bYjN5vN",
      "https://www.youtube.com/embed/2x_Fl3NQVd4?list=PLdMisKontG3gHkeGlECyYfgt62bYjN5vN",
      "https://www.youtube.com/embed/Y2mk_zZCZVE?list=PLdMisKontG3gHkeGlECyYfgt62bYjN5vN",
      "https://www.youtube.com/embed/Ip2ZGND1I9Q?list=PLdMisKontG3gHkeGlECyYfgt62bYjN5vN",
      "http://www.stumbleupon.com/su/3bA1d0/dVW9ndUi:49WCd1A4/parentpalace.com/2012/09/albert-einstein-quotes/",
      "http://www.stumbleupon.com/su/6qad5B/e8zNJr2q:49WCd1A4/addicted2success.com/quotes/40-rare-motivational-inspirational-picture-quotes/"
  ]

  questions.each_with_index do |question,index|
    myquestion = Question.new(:content=>question,:video_url=>videos[index])
    myquestion.save
  end
  


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
