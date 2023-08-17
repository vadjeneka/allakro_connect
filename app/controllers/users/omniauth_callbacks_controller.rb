class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
  skip_before_action :verify_authenticity_token, only: :facebook

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.create_from_provider_data(request.env["omniauth.auth"])

    if @user.persisted?
      sign_out_all_scopes
      sign_in_and_redirect root_path, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_session_path
    end
  end

  def google_oauth2
    user = User.from_omniauth(from_google_params)

    if user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect root_path, event: :authentication
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
  end
  
    def failure
      redirect_to root_path
    end

  protected

  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  # def after_sign_up_path_for(resource_or_scope)
  #   stored_location_for(resource_or_scope) || root_path
  # end

  # after_inactive_sign_up_path_for

  private

  def from_google_params
    @from_google_params ||= {
      uid: auth.uid,
      email: auth.info.email,
      full_name: auth.info.name
    }
  end

  def auth
    @auth ||= request.env['omniauth.auth']
  end

  
end
