class Users::FacebookAuthService < BusinessProcess::Base
  needs :fb_auth_params

  steps :fetch_facebook,
        :find_or_create_user

  def call
    process_steps
    @user
  end

  private
    def fetch_facebook
      graph = Koala::Facebook::API.new(
                fb_auth_params[:access_token], 
                Rails.application.credentials.facebook_private_key)
      begin
        @facebook_user = graph.get_object("me", fields: [:name, :email])
      rescue Koala::Facebook::AuthenticationError => e
        fail(:facebook_auth_error)
      rescue Exception => e
        fail(:unknow_error)
      end
    end

    def find_or_create_user
      @user = where(provider: "facebook", uid: @facebook_user["id"]).first
      return @user if @user != nil
      
      @user = where(provider: "email", email: @facebook_user["email"]).first
      return @user if @user != nil

      # If you need facebook avatar use: 
      # require 'open-uri'
      # tempfile = open("https://graph.facebook.com/#{@facebook_user["id"]}/picture") 
      # User.create(avatar: tempfile)    
      @user = User.create(provider: "facebook", uid: @facebook_user["id"],
                          email: @facebook_user["email"], name: @facebook_user["name"],
                          password: Devise.friendly_token[0,20])
    end    
end


