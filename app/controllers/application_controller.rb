class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action -> { flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice] }

  protected

    def after_sign_in_path_for(resource)
      sign_in_url = new_user_session_url
      if request.referer == sign_in_url
        super
      elsif request.referrer == user_facebook_omniauth_authorize_url && resource.sign_in_count == 1
        resource
      elsif request.referrer == user_facebook_omniauth_authorize_url && resource.sign_in_count > 1
        root_path
      else
        stored_location_for(resource) || request.referer || root_path
      end
    end

    def after_sign_out_path_for(_resource_or_scope)
      new_user_session_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :gender, :avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :gender])
    end
end
