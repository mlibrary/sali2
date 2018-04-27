# app/use_cases/get_availabilities.rb


class GetAvailabilities
  def initialize(user, request_id, calendar_ids={}, persistence_class: SessionRequest)

  end

  def call
    # check authorization for the current user to take the action
    # validate that required attributes are available to take the action
    # send request to google calendar api
  end

  def result

  end

  def validate

  end
end