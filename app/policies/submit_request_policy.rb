
class SubmitRequestPolicy
  attr_reader :user, :resource
  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def allowed?
    resource.requested_by == user
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send action
  end
end