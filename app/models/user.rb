class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


  # This is the captain's team relation
  has_one :my_team, class_name: "Team", foreign_key: "captain_id"
  #for avatar
  mount_uploader :avatar, AvatarUploader
  # This is the teammates realtion
  belongs_to :team

  # chat relationship for user to user
  has_many :conversations, :foreign_key => :sender_id
  has_many :conversations, :foreign_key => :recipient_id

  has_many :messages

  # belongs_to :captain, class_name: "User"

  # has_many :teammates, class_name: "User", foreign_key: "captain_id"
  belongs_to :vidconference


  has_one :teammate_relationship, foreign_key: "receiver_id"
  has_one :teammate_relationship, foreign_key: "sender_id"
  #TODO fix relationship when its made between sender and receiver
  #TODO look into dependent destory for user who deletes account with relationship
  has_one :individual_relationship, foreign_key: "receiver_id"
  has_one :individual_relationship, foreign_key: "sender_id"

  scope :captains, ->  { find Team.select(:captain_id).map(&:captain_id) }

  #TODO make validation not work for update of answers

  # def user_count_within_limit
  #   if vidconference && vidconference.users.count > 1
  #     errors.add(:base, "Exceeded thing limit")
  #   end
  # end

  # validate :user_count_within_limit, :on => :update

has_many :answers, dependent: :destroy
geocoded_by :location   # can also be an IP address
after_validation :geocode          # auto-fetch coordinates
reverse_geocoded_by :latitude, :longitude

attr_writer :address
  def address
    @address || location
  end

  def self.location_search(location)
    Geocoder.configure(:timeout => 4)

    Geocoder.search(location).map do |loc|
      city = "#{loc.city}, " if loc.city
      state = "#{loc.state}, " if loc.state
      "#{city}#{state}#{loc.country}"
    end
  end
  def self.to_geojson
   # json_string_start = {"type" => "FeatureCollection", "features" => [{"type" => "Feature","properties" => [{"TeamName" => nil,"TeamSport" => nil, "TeamAddress" => nil  }], "geometry" => {"type" => "Point" , "coordinates" => [nil,nil]}}]}
   # 
    geo = {"type" => "FeatureCollection", "features" => []}
    User.select([:latitude, :longitude]).distinct.each do |coords|
      # users = User.where(latitude: coords.latitude, longitude: coords.longitude).order("RANDOM()").map do |user|
      users = User.near([coords.latitude, coords.longitude], 2, :units => :km).order("RANDOM()").map do |user|
        {"TeamName" => user.name,  "TeamAddress"=> user.location, "TeamPicUrl"=> user.avatar.profile.url, "TeamProfileUrl"=>Rails.application.routes.url_helpers.individual_show_path(user.id),"TravelStatus"=>user.travel_status }
      end
      geo["features"] << {"type" => "Feature", "properties" => users, "geometry" => {"type" => "Point", "coordinates" => [coords.longitude, coords.latitude]}}
    end
    geo
  end
  def self.validate_address(location)
    coordinates = Geocoder.coordinates(location)
    address = Geocoder.address(coordinates)
  end

## role for user
  def teammate?
   role == 'teammate'
  end

  def team_captain?
    role == 'captain'
  end
   def individual?
    role == 'individual'
  end
  def admin?
    role == 'admin'
  end
#friendship status
  def friendship_eligible?
    friendship_eligible == true
  end

# travel status
  def traveler?
    travel_status == 'traveler'
  end

  def host?
    travel_status == 'host'
  end

end

