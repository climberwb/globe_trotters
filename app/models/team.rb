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
    team_hash = Hash.new

    location = []
    Team.all.each do |team|

      if location.include?("#{team.longitude} #{team.latitude}") == false #array.has_key?
        location << "#{team.longitude} #{team.latitude}"
        team_hash["#{team.longitude} #{team.latitude}"] = []
         team_hash["#{team.longitude} #{team.latitude}"] << {"TeamName" => team.name, "TeamSport" => team.sport, "TeamAddress"=> team.address }
       else
           team_hash["#{team.longitude} #{team.latitude}"] << {"TeamName" => team.name, "TeamSport" => team.sport, "TeamAddress"=> team.address }
      end
    end

   geo_string =  {"type" => "FeatureCollection", "features" => team_hash.map do |coords,string|
    coords1 = coords.split(' ')[0].to_f
    coords2 = coords.split(' ')[1].to_f
    if coords.split(" ") != []
      {"type" => "Feature","properties" => string, "geometry" => {"type" => "Point" , "coordinates" => [coords1,coords2]}}
      else
         {"type" => "Feature","properties" => string, "geometry" => {"type" => "Point" , "coordinates" => [1,1]}}
     end
    end
    }
   geo_string
    # coordinates_exist = false
    # Team.all.each do |team|
    #   json_string_start['features'].each do |feature|
    #     #Team.all.map do |team|
    #       if  (feature['geometry']['coordinates'] == [team.longitude, team.latitude])
    #              feature['properties'] << {"TeamName" => team.name,"TeamSport" => team.sport, "TeamAddress" => team.location}
    #              coordinates_exist = true
    #            break
    #       end
    #     #end
    #   end
    #      if coordinates_exist == false
    #         json_string_start['features'] << {"type" => "Feature","properties" => [{"TeamName" => team.name,"TeamSport" => team.sport, "TeamAddress" => team.location  }], "geometry" => {"type" => "Point" , "coordinates" => [team.longitude, team.latitude]}}
    #         coordinates_exist = false
    #     end
    # end
   # json_string_start

    # {"type" => "FeatureCollection", "features" => Team.all.map do |team|
    #     {"type" => "Feature","properties" => {"TeamName" => team.name,"TeamSport" => team.sport, "TeamAddress" => team.location  }, "geometry" => {"type" => "Point" , "coordinates" => [team.longitude, team.latitude]}}
    # end
    # }
  end
  def self.validate_address(location)
    coordinates = Geocoder.coordinates(location)
    address = Geocoder.address(coordinates)
    # Geocoder.coordinates("25 Main St, Cooperstown, NY")
    # Geocoder.address([42.700124, -74.922749])
  end

  # making home_team the multiple team chat relation
 # belongs_to :group_conversation, class_name: "Conversation"
end