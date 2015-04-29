module ApplicationHelper
  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def show_menu_policy?
    @Individual_Relationship = IndividualRelationship.where(receiver: current_user).first
    if user_signed_in?
      @Individual_Relationship.nil? ? false : true#policy(current_user).index?
    else
      false
    end
  end
end
