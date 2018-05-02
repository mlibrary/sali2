# app/models/policies/set_registration_policy.rb

class SetRegistrationPolicy
  attr_reader :user, :resource
  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def allowed?
    user.has_role?('scheduler') || user.has_role?('admin')
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send action
  end
end