class IndividualRelationshipsController < ApplicationController


  def index
    @relationships = IndividualRelationship.where(receiver: current_user.individual_relationship)
  end

  def show

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
    sender_id = params[individual_relationships][:sender_id].to_i
    receiver_id = params[individual_relationships][:receiver_id].to_i
    sender_name = Individual.find(sender_id).name
    # @relationship = IndividualRelationship.where(params[individual_relationships][:sender_id]).where(params[individual_relationships][:receiver_id]).first

    @relationship = IndividualRelationship.where(sender_id: sender_id, receiver_id: receiver_id).first
    @relationship_accept = @relationship.update_attributes(:accepted_at=> Time.new)
    @relationship.save!
    render :json => {:status => "Accept",:Individual =>{:link =>"Individuals/#{sender_id}", :name => sender_name} }.to_json
   #
  end

  def decline
    sender_id = params[individual_relationships][:sender_id].to_i
    receiver_id = params[individual_relationships][:receiver_id].to_i

    @relationship = IndividualRelationship.where(sender_id: sender_id, receiver_id: receiver_id).first
    @relationship_accept = @relationship.update_attributes(:rejected_at=> Time.new)
    render :json => {:status => "Decline" }.to_json
  end

  protected
  def message_params
    params.require(:individual_relationships).permit(:sender_id, :receiver_id)
  end
end