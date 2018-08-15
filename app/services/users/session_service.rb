class Users::SessionService < BusinessProcess::Base
  needs :session_params

  steps :find_user,
        :verify_password

  def call
    process_steps
    @user
  end

  private
    def find_user
      unless @user = User.find_for_database_authentication(email: session_params[:email])
        fail(:user_not_found)
      end
    end

    def verify_password
      unless @user.valid_password?(session_params[:password])
        fail(:invalid_credentials)
      end
    end
end


