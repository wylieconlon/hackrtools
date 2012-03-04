module ApplicationHelper
  def signed_in?
    return !current_user.nil?
  end
end
