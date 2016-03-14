class UserAuthorizationPolicy
  def initialize(user, controller, action, params)
    @user, @action, @controller, @params = user, action, controller, params
    @resource = controller.classify.constantize.find(@params[:id]) rescue nil
  end

  def authorized?
    @user.admin? || authorized_to_action?
  end

  private

  def read_action?
    %w(show index).include?(@action)
  end

  def user_specific_action?
    !@user.guest? && ((@action == 'create' && authorized_to_create?) || (!@resource.nil? && @user.id == @resource.user_id))
  end

  def authorized_to_action?
    read_action? || user_specific_action?
  end

  def authorized_to_create?
    parent_resource = @params.keys.find { |param| param.end_with?('_id') } rescue nil
    if parent_resource.nil?
      @controller == 'users'
    else
      parent_resource.split('_').first.classify.constantize.find(@params[parent_resource]).user_id == @user.id
    end
  end
end
