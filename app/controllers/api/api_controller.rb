class Api::ApiController < ActionController::API
  include APITokenAuthenticatable
  include APICommonResponses

  respond_to :json

  protected

    def authenticate_user_from_token!
      authenticate_from_token! User
    end
end