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
  has_one :team_relationship, foreign_key: "receiver_id"
  has_one :team_relationship, foreign_key: "sender_id"
  
  mount_uploader :avatar, AvatarUploader

  attr_writer :address

  def address
    @address || location
  end

  def self.location_search(location)
    Geocoder.search(location).map do |loc|
      city = "#{loc.city}, " if loc.city
      state = "#{loc.state}, " if loc.state
      "#{city}#{state}#{loc.country}"
    end
  end

  def self.to_geojson
   # json_string_start = {"type" => "FeatureCollection", "features" => [{"type" => "Feature","properties" => [{"TeamName" => nil,"TeamSport" => nil, "TeamAddress" => nil  }], "geometry" => {"type" => "Point" , "coordinates" => [nil,nil]}}]}
   # binding.pry
    geo = {"type" => "FeatureCollection", "features" => []}
    Team.select([:latitude, :longitude]).distinct.each do |coords|
      teams = Team.where(latitude: coords.latitude, longitude: coords.longitude).order("RANDOM()").map do |team|
        {"TeamName" => team.name, "TeamSport" => team.sport, "TeamAddress"=> team.address, "TeamPicUrl"=> team.avatar.profile.url, "TeamProfileUrl"=>Rails.application.routes.url_helpers.team_path(team.id) }
      end
      geo["features"] << {"type" => "Feature", "properties" => teams, "geometry" => {"type" => "Point", "coordinates" => [coords.longitude, coords.latitude]}}
    end
    geo
  end
  def self.validate_address(location)
    coordinates = Geocoder.coordinates(location)
    address = Geocoder.address(coordinates)
  end

  # making home_team the multiple team chat relation
 # belongs_to :group_conversation, class_name: "Conversation"
end