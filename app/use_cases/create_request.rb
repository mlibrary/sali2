class CreateRequest
  def initialize(user, attribute_hash, persistence_class: SessionRequest)
    @user = user
    @attribute_hash = attribute_hash
    @persistence_class = persistence_class
  end
end