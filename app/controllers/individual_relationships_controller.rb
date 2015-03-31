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
    individual_relationships = IndividualRelationship.where(receiver: current_user)
    relationship_display = []
    relationships = {"users" => []}
    if individual_relationships.where.not(accepted_at: nil).length == 0
        relationship_display = individual_relationships.each do |relationship|
          relationships["users"] << {"name"=>relationship.sender.name, "url"=>individual_show_path(relationship.sender), "avatar"=>relationship.sender.avatar, "id"=>relationship.sender.id.to_s}
        end
        render :json => relationships.to_json
    else
      friend = individual_relationships.where(rejected_at: nil).first
      relationships["users"] << {"name"=>friend.sender.name, "url"=>individual_show_path(friend.sender), "avatar"=>relationship.sender.avatar, "id"=>relationship.sender.id.to_s}
      render :json => relationships.to_json
    end
  end

  def new
    @relationship=IndividualRelationship.new
  end

  def create
    #binding.pry
    @relationship = IndividualRelationship.create!(message_params)
    @relationship.save
    render :json => {:status => "Request Sent" }.to_json

  end

  def destroy
  end

  def update
  end

  def accept
    sender_id = params[:sender_id].to_i
    receiver_id = current_user.id
   # sender_name = IndividualRelationship.find(sender_id).name
    # @relationship = IndividualRelationship.where(params[individual_relationships][:sender_id]).where(params[individual_relationships][:receiver_id]).first

    @relationship = IndividualRelationship.where(sender_id: sender_id, receiver_id: receiver_id).first
    @relationship_accept = @relationship.update_attributes(:accepted_at=> Time.new)
    @relationship.save!
    render :json => {:status => "Accept",:individual =>{:link =>"Individuals/#{sender_id}", :name => @relationship.sender.name} }.to_json
   #
  end

  def decline
    sender_id = params[:individual_relationships][:sender_id].to_i
    receiver_id = params[:individual_relationships][:receiver_id].to_i

    @relationship = IndividualRelationship.where(sender_id: sender_id, receiver_id: receiver_id).first
    @relationship_accept = @relationship.update_attributes(:rejected_at=> Time.new)
    render :json => {:status => "Decline" }.to_json
  end

  protected
  def message_params
    params.require(:individual_relationships).permit(:sender_id, :receiver_id)
  end
end