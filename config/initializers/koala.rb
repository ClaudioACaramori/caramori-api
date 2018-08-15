Koala.configure do |config|
  config.app_id = Rails.application.credentials.facebook_app_id
  config.app_secret = Rails.application.credentials.facebook_secret_key
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end
