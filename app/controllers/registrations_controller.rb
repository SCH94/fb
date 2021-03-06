class RegistrationsController < Devise::RegistrationsController

  def create
    super
    if resource.persisted?
      UserMailer.welcome_email(resource).deliver_later
      UserMailer.new_signup(resource).deliver_later
    end
  end

  protected

    def after_sign_up_path_for(resource)
      resource
    end

    def after_update_path_for(_resource)
      resource
    end

end
