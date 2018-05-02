# app/models/policies/create_request_policy.rb

class CreateRequestPolicy
  attr_reader :user
  def initialize(user)
    @user = user
  end

  def allowed?
    # TODO: user is logged in?
    true
  end

  def authorize!(action, message = nil)
    raise NotAuthorizedError.new(message) unless send action
  end
end