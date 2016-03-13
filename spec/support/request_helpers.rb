module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end

  module AuthHelper
    def set_basic_auth_headers(username, password)
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(username,password)
    end
  end
end