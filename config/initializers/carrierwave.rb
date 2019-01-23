CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
    config.enable_processing = Rails.env.development?
    config.asset_host = "http://localhost:3000"
  else
    config.storage    = :aws
    config.aws_bucket = Rails.application.credentials[Rails.env.to_sym][:aws_s3_bucket_name]
    config.aws_acl    = 'public-read'

   config.aws_credentials = {
      access_key_id:     Rails.application.credentials[Rails.env.to_sym][:aws_s3_access_key_id],
      secret_access_key: Rails.application.credentials[Rails.env.to_sym][:aws_s3_secret_access_key],
      region:            Rails.application.credentials[Rails.env.to_sym][:aws_s3_region]
    }
  end
end

