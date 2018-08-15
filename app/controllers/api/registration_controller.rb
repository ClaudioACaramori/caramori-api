class Api::RegistrationController < Api::ApiController
  before_action :authenticate_user_from_token!, except: [:create]

  def create
    user = User.new(user_params)
    update_handler(user)
  end

  def update
    user = current_user.assign_attributes(user_params)
    update_handler(user)
  end

  private
    def user_params
      params.permit(:name, :email, :password, :password_confirmation)
    end

    def update_handler(resource)
      if resource.save
        headers = resource.refresh_token
        sign_in resource, store: false
        respond_with resource, location: '', scope: headers
      else
        render_unprocessable_entity_error(resource)
      end
    end
end
