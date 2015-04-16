module ApplicationHelper
  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def show_menu_policy?
    if user_signed_in?
      current_user.individual_relationship.nil? ? false : policy(current_user.individual_relationship).index?
    else
      false
    end
  end
end
