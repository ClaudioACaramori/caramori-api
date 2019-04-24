RailsAdmin.config do |config|
  config.authorize_with do
    authenticate_or_request_with_http_basic('Caramori') do |username, password|
      username == 'admin' && password == 'admin'
    end
  end

  config.main_app_name = ['Caramori', 'Admin']

  config.excluded_models = ['ActiveStorage::Blob', 'ActiveStorage::Attachment']

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
