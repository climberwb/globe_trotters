class Answer < ActiveRecord::Base
belongs_to :user
belongs_to :icebreaker_session
end
