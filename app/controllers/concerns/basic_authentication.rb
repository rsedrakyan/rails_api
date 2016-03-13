require 'active_support/concern'

module BasicAuthentication
  extend ActiveSupport::Concern
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def authenticate_user_with_basic_auth!
    authenticate_or_request_with_http_basic do |username, password|
      resource = User.find_by(email: username)
      if resource && resource.valid_password?(password)
        @current_user = resource
        sign_in(:user, resource)
      end
    end
  end
end
