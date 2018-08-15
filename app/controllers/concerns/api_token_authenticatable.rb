# Esse arquivo é padrão do time WEB, portanto foi apenas trazido de outros lugares

include APICommonResponses

module APITokenAuthenticatable
  extend ActiveSupport::Concern

  # You can use any model, like Admin or Driver, just sent headers like above pattern
  # HTTP_#{model_name}_EMAIL and HTTP_#{model_name}_TOKEN
  def authenticate_from_token!(model)
    user, request_token = find_authenticable_by_headers(model)

    if user.present? && user.token_match?(request_token)
      @user ||= user
      sign_in user, store: false
    else
      render_unauthorized_error
    end
  end

  def find_authenticable_by_headers(model)
    model_name = model.name.upcase

    request_email = request.headers["HTTP_#{model_name}_EMAIL"].presence
    request_token = request.headers["HTTP_#{model_name}_TOKEN"].presence
    user          = request_email && model.find_by(email: request_email)

    return user, request_token
  end
  
  def current_user
    @user
  end

  def build_header_response(headers)
    headers.map { |key,value| response.headers[ key.to_s ] = value.to_s }
  end

end
