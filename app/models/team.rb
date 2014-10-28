class Team < ActiveRecord::Base
   # belongs_to :captain, class_name: "User"
    has_many :teammates, class_name: "User"
end