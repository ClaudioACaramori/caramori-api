RailsAdmin.config do |config|
  config.main_app_name = ['Caramori', 'Admin']

  config.authorize_with do
    authenticate_or_request_with_http_basic('Caramori') do |username, password|
      username == 'admin' && password == 'admin'
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
