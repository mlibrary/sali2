# app/models/use_cases/update_request.rb

class UpdateRequest
  def initialize(user, request_id, changes={}, persistence_class: SessionRequest)

  end

  def call
    # check authorization for the current user to take the action
    # validate that required attributes are available to take the action
    # update the session-request object
    # add or update calendar event in the instruction calendar (once the scheduled time is set)
    # add or update calendar event in the room calendar (once the room is set)
  end

  def validate

  end
end