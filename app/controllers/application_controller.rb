class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user
    unless current_user
      redirect_to new_user_session_path, alert: "You don't have access to this page"
    end
  end
end
