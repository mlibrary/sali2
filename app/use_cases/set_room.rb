# app/models/use_cases/set_room.rb

class SetRoom
  def initialize(user, request_id, room_id, scheduled_time: nil, persistence_class: SessionRequest)

  end

  def call
    # find the request
    request = persistence_class.find(request_id)

    # check authorization for the current user to take the action

    # validate required attributes to take the action
    validate

    # update the session-request object
    # tell the calendar that changes have been made to the request
    Calendar.new.room_assigned(request)

    # save updates?
  end

  def validate

  end
end