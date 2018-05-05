class Calendar
  attr_reader :calendar_service

  def initialize(calendar_service: Services.calendar)
    @calendar_service = calendar_service
  end

  def evaluation_assigned(request)
    # return unless scheduled-time is set
    return if request.scheduled_time.nil? || request.scheduled_time.empty?

    # add-or-update event in instruction-calendar (changes: description)
    instruction_event_hash = compose_instruction_event(request)
    calendar_service.add_or_update_instruction_calendar(instruction_event_hash)

    # return unless room is set
    return if request.location.nil? || request.location.empty?

    # add-or-update event in room-calendar (changes: description)
    location_event_hash = compose_location_event(request)
    calendar_service.add_or_update_location_calendar(location_event_hash)
  end

  def instructor_assigned(request)
    # return unless scheduled-time is set
    # add-or-update event in instruction-calendar (changes: description and guests)
    # return unless room is set
    # add-or-update event in room-calendar (changes: description)
    #
    # is this called if an instructor is removed, or is there a separate message for that?

  end

  def registration_assigned(request)
    # return unless scheduled-time is set
    # add-or-update event in instruction-calendar (changes: description)
    # return unless room is set
    # add-or-update event in room-calendar (changes: description)

  end

  def room_assigned(request)
    # not called unless scheduled time and room are both set
    #
    # if there's an existing event in a room-calendar, remove it
    # new event needs to be added to the calendar for the new room
    # if there's an existing event in an instruction-calendar, it needs to be updated
    # otherwise new event needs to be added to the appropriate calendar

  end

  def class_sections_changed(request)
    # return unless scheduled-time is set
    # add-or-update event in instruction-calendar (changes: title, description)
    # return unless room is set
    # add-or-update event in room-calendar (changes: title, description)

  end

  def other_attributes_changed(request)
    # topics, contact_person, etc
    # Mostly affect description
    #
    # return unless scheduled-time is set
    # add-or-update event in instruction-calendar (changes: description)
    # return unless room is set
    # add-or-update event in room-calendar (changes: description)

  end

  def session_scheduled(session, request=nil)

  end

  private

  def compose_instruction_event(request)
    #returns a hash containing all info needed to add/update an event
    # including the calendar-id, event-id (if available), the title,
    # the description, the guests, etc
    {}
  end

  def compose_location_event(request)
    #returns a hash containing all info needed to add/update an event
    # including the calendar-id, event-id (if available), the title,
    # the description, the guests, etc
    {}
  end
end