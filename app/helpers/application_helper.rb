module ApplicationHelper
  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def show_menu_policy?
    if user_signed_in?
       @Individual_Relationship =  IndividualRelationship.where("sender_id = ? OR receiver_id = ? ", current_user.id, current_user.id).first
      ((@Individual_Relationship.nil? ? false : true ) && current_user.host?) || (current_user.traveler? && @Individual_Relationship && @Individual_Relationship.accepted_at)   #policy(current_user).index?
    else
      false
    end
  end

end
