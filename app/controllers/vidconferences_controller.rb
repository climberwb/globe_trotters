class VidconferencesController < ApplicationController

    def new
      @new_session = Vidconference.new

    end
    def create
        # Replace with your OpenTok API key:
        api_key = ENV['OPENTOK_KEY']
        # Replace with your OpenTok API secret:
        api_secret = ['OPENTOK_SECRET_KEY']

        opentok = OpenTok::OpenTok.new api_key, api_secret
        session = opentok.create_session
        @new_session = Vidconference.create!(:session => session)

        @new_session.users << current_user
        @new_session.users << User.find(params[:vidconference][:user_id])
    end

    def show
      @vidconference = current_user.vidconference.session
       # Replace with your OpenTok API key:
        api_key = ENV['OPENTOK_KEY']
        # Replace with your OpenTok API secret:
        api_secret = ['OPENTOK_SECRET_KEY']

        opentok = OpenTok::OpenTok.new api_key, api_secret
        @token = @vidconference.session_id.generate_token
    end

end
