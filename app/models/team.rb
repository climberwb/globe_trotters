class Team  < ActiveRecord::Base
  
  belongs_to :captain, class_name: "User"
end