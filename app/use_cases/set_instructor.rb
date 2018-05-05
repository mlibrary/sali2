# app/models/use_cases/set_instructor.rb

class SetInstructor
  def initialize(user, request_id, instructor_id, scheduled_time: nil, persistence_class: SessionRequest)

  end

  def call
    # check authorization for the current user to take the action
    # validate that required attributes are available to take the action
    # update the session-request object

    # validate required attributes to have calendar events
    # instantiate a calendar client
    # add or update calendar event in the instruction calendar
    #   (once the scheduled time is set)
    #   calendar.add_or_update_instruction_calendar(request)
    #   update the session-request object
    # add or update calendar event in the room calendar
    #   (once the scheduled time and room is set)
    #   calendar.add_or_update_room_calendar(request)
    #   update the session-request object
    # save updates?
  end

  def validate

  end
end