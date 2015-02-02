class Team < ActiveRecord::Base
   # belongs_to :captain, class_name: "User"
  belongs_to :captain, class_name: "User"
  has_many :teammates, class_name: "User"

  #this represents just the internal chat
  has_one :conversation

  # team has one team that would like to stay in contact with
  # has_one :visiting_team, class_name: "Team", foreign_key: "visiting_team_id"
  # has_one :home_team, class_name: "Team", foreign_key: "home_team_id"

  # validates_presence_of :conversation

  geocoded_by :location   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates
  
  reverse_geocoded_by :latitude, :longitude 

  #do |obj, results|
    #p results


  #end

  mount_uploader :avatar, AvatarUploader

  attr_writer :address

  def address
    @address || location
  end

  def self.to_geojson 
    {"type" => "FeatureCollection", "features" => all.map do |team| 
      {"type" => "Feature", "geometry" => {"type" => "Point" , "coordinates" => [team.longitude, team.latitude]}} 
    end 
    }.to_json 
  end
  


  # making home_team the multiple team chat relation
 # belongs_to :group_conversation, class_name: "Conversation"

end