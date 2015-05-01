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
    #TODO make sure if there is an  accepted at it does not make it to the view
    individual_relationships = IndividualRelationship.where(receiver: current_user)
    authorize individual_relationships

    relationship_display = []
    relationships = {"users" => []}
   # 
    if individual_relationships.where.not(accepted_at: nil).length > 0
      #bindig.pry
      friend = individual_relationships.where.not(accepted_at: nil).first
      friendStatus = true
      relationships["users"] << {"name"=>friend.sender.name, "url"=>individual_show_path(friend.sender), "avatar"=>friend.sender.avatar, "id"=>friend.sender.id.to_s,"friendStatus"=>friendStatus.to_s}
      render :json => relationships.to_json

    else
        #
        relationship_display = individual_relationships.each do |relationship|
          #friend.accepted_at ? friendStatus = true : friendStatus = false
          if relationship.rejected_at == nil
            relationships["users"] << {"name"=>relationship.sender.name, "url"=>individual_show_path(relationship.sender), "avatar"=>relationship.sender.avatar, "id"=>relationship.sender.id.to_s,"friendStatus"=>"false"}
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
    sender_id = params[:sender_id].to_i
    receiver_id = current_user.id
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

  end

  def update
  end

  def accept
    sender_id = params[:sender_id].to_i
    receiver_id = current_user.id
    sender = User.find(sender_id)
  
    @relationship = IndividualRelationship.where(sender_id: sender_id, receiver_id: receiver_id).first
    #TODO redirect to at Vidconferences controller and have route display json string

    @relationship.update_attributes(:accepted_at=> Time.new)
    @relationship.save!
    Vidconference.create_vidconference(sender,current_user.id)
    render :json => {:status => "Accept",:vidconference_id =>sender.vidconference_id,:individual =>{:link =>"Individuals/#{sender_id}", :name => @relationship.sender.name} }.to_json
   #
  end

  def decline
    sender_id = params[:sender_id].to_i
    receiver_id = current_user.id
    #
    @relationship = IndividualRelationship.where(sender_id: sender_id, receiver_id: receiver_id).first
    @relationship_accept = @relationship.update_attributes(:rejected_at=> Time.new)
    render :json => {:status => "Decline" }.to_json
  end

  protected
  def message_params
    params.require(:individual_relationships).permit(:sender_id, :receiver_id)
  end
end