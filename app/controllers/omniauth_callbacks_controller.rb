class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.persisted?
      sign_in_and_redirect user
      set_flash_message :notice, :success, kind: 'Facebook'
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_path
    end
  end

  def failure
    redirect_to new_user_session_path
  end
end
