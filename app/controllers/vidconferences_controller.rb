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
        if @new_session.users.length == 2  
          @new_session.save
          redirect_to @new_session
        else 
          @new_session.destroy
          redirect_to Vidconference.new
        end
    end

    def show
     # 
      @vidconference = current_user.vidconference
      if  @vidconference==nil 
        redirect_to root_path 
      else
        vidconference_session = current_user.vidconference.session
         # Replace with your OpenTok API key:
         @session = vidconference_session
         #authorize @vidconference
          api_key = ENV['OPENTOK_KEY']
          # Replace with your OpenTok API secret:
          api_secret = ENV['OPENTOK_SECRET_KEY']
          #
          opentok = OpenTok::OpenTok.new api_key, api_secret
         # @videoconference = opentok.create_session.session_id
          @token = opentok.generate_token(vidconference_session)

          #        opentok.generate_token(@videoconference)
      end
    end

end
