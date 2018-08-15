RailsAdmin.config do |config|
  config.main_app_name = ['YourAppName', 'Admin']

  config.authorize_with do
    authenticate_or_request_with_http_basic('YourAppName') do |username, password|
      username == Rails.application.credentials.admin_username &&
      password == Rails.application.credentials.admin_password
    end
  end

  config.actions do
    dashboard
    index
    new
    bulk_delete
    show
    edit
    delete
  end
end
