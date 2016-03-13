class ApplicationController < ActionController::Base
  include ActionController::Serialization
  include BasicAuthentication
  include HttpErrorHandling

  before_filter :authenticate_user_with_basic_auth!
  before_filter :authorize_user

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  helper_method :current_user

  def default_serializer_options
    {root: false}
  end

  private

  def authorize_user
    unless UserAuthorizationPolicy.new(current_user, controller_name, action_name, params[:id]).authorized?
      render json: { error: t('user.unauthorized_resource') }, status: :unprocessable_entity
    end
  end

  def current_user
    @current_user
  end
end
