class Api::SessionsController < Api::ApiController

  def create
    reponse_handler(Users::SessionService.call(session_params: session_params))
  end

  def facebook_auth
    reponse_handler(Users::FacebookAuthService.call(fb_auth_params: fb_auth_params))
  end

  private
    def session_params
      params.permit(:email, :password)
    end

    def fb_auth_params
      params.permit(:access_token)
    end
  
    def reponse_handler(response)
      if response.success?
        headers = response.result.refresh_token
        sign_in response.result, store: false
        respond_with response.result, location: '', scope: headers
      else
        render_unprocessable_entity_error(response)
      end
    end
end