# app/models/policies/update_request_policy.rb

class UpdateRequestPolicy
  attr_reader :user, :resource
  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def allowed?
    resource.requested_by == user ||
        user.has_role?('instructor') ||
        user.has_role?('scheduler') ||
        user.has_role?('admin')
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send action
  end
end