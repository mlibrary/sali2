# app/models/use_cases/create_request.rb

class CreateRequest
  def initialize(user, attribute_hash, persistence_class: SessionRequest)
    @user = user
    @attribute_hash = attribute_hash
    @persistence_class = persistence_class
  end

  def call
    # check authorization for the current user to take the action
    # validate that required attributes are available to take the action
    # create and save SessionRequest object
  end

  def validate

  end
end