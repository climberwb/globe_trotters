class IndividualRelationshipsController < ApplicationController


  def index
    individual_relationships = IndividualRelationship.where(receiver: current_user)
    @relationship_display = []
    if individual_relationships.where.not(accepted_at: nil).length == 0
        @relationship_display = individual_relationships.where(rejected_at: nil)
    else
      @friend = individual_relationships.where(rejected_at: nil).first
    end
  end

  def show
    #TODO Finish json sting then use index controller instead of show
    #individual_relationships =IndividualRelationship.where(receiver: current_user)
    individual_relationships = IndividualRelationship.where("receiver_id = ? OR sender_id = ? ", current_user, current_user)
    authorize individual_relationships

    relationship_display = []
    relationships = {"users" => []}
   #
    if individual_relationships.where.not(accepted_at: nil).length > 0
      friend = individual_relationships.where.not(accepted_at: nil).first
      friendStatus = true
      if current_user.host?
        relationships["users"] << {"name"=>friend.sender.name, "url"=>individual_show_path(friend.sender), "avatar"=>friend.sender.avatar, "id"=>friend.sender.id.to_s,"friendStatus"=>friendStatus.to_s,"travel_status"=>friend.sender.travel_status}
      elsif current_user.traveler?
        relationships["users"] << {"name"=>friend.receiver.name, "url"=>individual_show_path(friend.receiver), "avatar"=>friend.receiver.avatar, "id"=>friend.receiver.id.to_s,"friendStatus"=>friendStatus.to_s,"travel_status"=>friend.receiver.travel_status}
      end
      render :json => relationships.to_json

    else
        #
        relationship_display = individual_relationships.each do |relationship|
          #friend.accepted_at ? friendStatus = true : friendStatus = false
          if relationship.rejected_at == nil
            relationships["users"] << {"name"=>relationship.sender.name, "url"=>individual_show_path(relationship.sender), "avatar"=>relationship.sender.avatar, "id"=>relationship.sender.id.to_s,"friendStatus"=>"false","travel_status"=>current_user.travel_status}
          end
       # friendStatus ?
        end
        render :json => relationships.to_json
    end
  end

  def new
    @relationship=IndividualRelationship.new
  end

  def create
    #
    @relationship = IndividualRelationship.create!(message_params)
    @relationship.save
    render :json => {:status => "Request Sent" }.to_json

  end
  def delete
    if current_user.traveler?
      sender_id = current_user.id
      receiver_id = params[:delete_friend][:user_id].to_i
    elsif current_user.host?
      sender_id = params[:delete_friend][:user_id].to_i
      receiver_id = current_user.id
    end

    Vidconference.find(current_user.vidconference_id).destroy
    @relationship = IndividualRelationship.where(sender_id: sender_id, receiver_id: receiver_id).first.destroy
    individual_relationships = IndividualRelationship.where(receiver: current_user)
    relationship_display = []
    relationships = {"users" => []}
    relationship_display = individual_relationships.each do |relationship|
          #friend.accepted_at ? friendStatus = true : friendStatus = false
          if relationship.rejected_at == nil
            relationships["users"] << {"name"=>relationship.sender.name, "url"=>individual_show_path(relationship.sender), "avatar"=>relationship.sender.avatar, "id"=>relationship.sender.id.to_s,"friendStatus"=>"false"}
          end
       # friendStatus ?
        end
    render :json => relationships.to_json
  end
  def destroy
    sender_id = message_params[:sender_id].to_i
    receiver_id = message_params[:receiver_id].to_i
    #
    @relationship = IndividualRelationship.where(sender_id: sender_id, receiver_id: receiver_id).first
    @relationship.destroy
    render :json => {:status => "Destroy" }.to_json
  end

  def update
  end

  def accept

    sender_id = params[:sender_id].to_i
    receiver_id = current_user.id
    sender = User.find(sender_id)
    relationships = IndividualRelationship.where(sender_id: sender_id, receiver_id: receiver_id)
    @relationship = relationships.first
    @relationship.update_attributes(:accepted_at=> Time.new)

    @relationship.save!
    # destroys all other relationships not accepted
    IndividualRelationship.where(receiver_id: receiver_id).where.not(sender_id: sender_id).each{|relationship| relationship.destroy}
    # creates video conference
    Vidconference.create_vidconference(sender,current_user.id)
    #sends email alerting of video conference
    # TODO get sendgrid username and pw for work computer
    # take care of exception that it still saves user if sendgrid fails
    # IndividualRelationship.mail(sender)

    render :json => {:status => "Accept",:vidconference_id =>sender.vidconference_id,:individual =>{:link =>"Individuals/#{sender_id}", :name => @relationship.sender.name} }.to_json
   #
  end

  def decline
    sender_id = params[:sender_id].to_i
    receiver_id = current_user.id
    #
    @relationship = IndividualRelationship.where(sender_id: sender_id, receiver_id: receiver_id).first
    @relationship.destroy
    render :json => {:status => "Decline" }.to_json
  end

  protected
  def message_params
    params.require(:individual_relationships).permit(:sender_id, :receiver_id)
  end
end