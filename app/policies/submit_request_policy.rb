
class SubmitRequestPolicy
  attr_reader :user, :resource
  def initialize(user, resource)
    @user = user
    @resource = resource
  end

  def allowed?
    resource.requested_by == user
  end
end