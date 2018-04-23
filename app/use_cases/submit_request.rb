class SubmitRequest
  def initialize(user, request_id, persistence_class: SessionRequest)
    @user = user
    @request_id = request_id
    @persistence_class = persistence_class
  end

  def call
    # retrieve obj
    request = @persistence_class.find(@request_id)

    # check checkpoint policies
    #

    # check validations
    @result = ModelValidations.validate_to_submit_for_scheduling(request.to_h)

    # call SessionRequest#submitted
    request.submitted if @result.success?
  end

  def errors
    @result.errors || {}
  end

  def success?
    raise Exception() unless @result
    @result.success?
  end

  def failure?
    raise Exception() unless @result
    @result.failure?
  end


end