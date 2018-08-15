#this is the intilizer
#here you will set up the jera push configuration
JeraPush.setup do |config|
  config.firebase_api_key = Rails.application.credentials.firebase_api_key 
  config.resources_name = ["User"]

  config.resource_attributes = [:email]

  # Topic default
  # You should put with your environment
  config.default_topic = "youapp_name_#{Rails.env}"

  # Admin credentials
  config.admin_login = {
    username: Rails.application.credentials.jerapush_user,
    password: Rails.application.credentials.jerapush_pass
  }

end
