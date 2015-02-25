class VidconferencesController < ApplicationController

    def new
      @vidconference = Vidconference.new

    end
    def create
        # Replace with your OpenTok API key:
        api_key = ENV['OPENTOK_KEY']
        # Replace with your OpenTok API secret:
        api_secret = ENV['OPENTOK_SECRET_KEY']

        opentok = OpenTok::OpenTok.new api_key, api_secret
        session = opentok.create_session
        @new_session = Vidconference.create!(:session => session.to_s)

        @new_session.users << current_user
        @new_session.users << User.find(params[:vidconference][:users])
        redirect_to @new_session
    end

    def show
     # binding.pry
      vidconference = current_user.vidconference.session
       # Replace with your OpenTok API key:
       @session = vidconference
        api_key = ENV['OPENTOK_KEY']
        # Replace with your OpenTok API secret:
        api_secret = ENV['OPENTOK_SECRET_KEY']
        #binding.pry
        opentok = OpenTok::OpenTok.new api_key, api_secret
       # @videoconference = opentok.create_session.session_id
        @token = opentok.generate_token(vidconference)

        #        opentok.generate_token(@videoconference)

    end

end
