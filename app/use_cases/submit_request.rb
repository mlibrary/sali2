class SubmitRequest
  def initialize(user, request_id)
    @user = user
    @request_id = request_id
  end

  def call
    # retrieve obj
    request = persistence.find(@request_id)

    # check policies

    # check validations
    result = ModelValidations.validate_to_submit_for_scheduling(request.to_h)

    # call SessionRequest#submitted
    request.submitted
  end
end