class UserAuthorizationPolicy
  def initialize(user, controller, action, resource_id = nil)
    @user, @action = user, action
    @resource = controller.classify.constantize.find(resource_id) rescue nil
  end

  def authorized?
    @user.admin? || authorized_to_action?
  end

  private

  def read_action?
    %w(show index).include?(@action)
  end

  def user_specific_action?
    !@user.guest? && (@action == 'create' || @user.id == @resource.user_id)
  end

  def authorized_to_action?
    read_action? || user_specific_action?
  end
end
