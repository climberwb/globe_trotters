class Vidconference < ActiveRecord::Base
has_many :users

# put this validates_presence_of :body, :conversation_id, :user_id
validates_presence_of :session

validates :users, :length => { :maximum => 2 }, :on => :update






end