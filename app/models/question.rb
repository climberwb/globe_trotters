class Question < ActiveRecord::Base
  has_many :icebreaker_sessions
  has_many :notebooks, :through => :icebreaker_sessions
end
