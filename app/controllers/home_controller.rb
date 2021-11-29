class HomeController < ApplicationController
  before_action :authenticate_user, only: [:index]
  def index
    user = User.find_by(email: current_user[:email])
    #raise current_user.inspect
    if user.first_name == nil && user.town ==nil && user.city == nil
      redirect_to edit_user_registration_path(user)
    end  
  end
end
