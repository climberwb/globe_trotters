class Vidconference < ActiveRecord::Base
has_many :users

# put this validates_presence_of :body, :conversation_id, :user_id
validates_presence_of :session

#validates :users, :length => { :maximum => 2 }, :on => :update

  def self.create_vidconference(sender,receiver)
    # Replace with your OpenTok API key:
    api_key = ENV['OPENTOK_KEY']
    # Replace with your OpenTok API secret:
    api_secret = ENV['OPENTOK_SECRET_KEY']
    opentok = OpenTok::OpenTok.new api_key, api_secret
    session = opentok.create_session
    @new_session = Vidconference.create!(:session => session.to_s)

    @new_session.users << sender
    @new_session.users << User.find(receiver)
    if @new_session.users.length == 2
      @new_session.save
     # redirect_to @new_session
    else
      @new_session.destroy
      puts 'session did not save'
    end
  end




end