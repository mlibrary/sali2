# Requesting and scheduling an Instructional Session is a multi-step process.
# This process is encapsulated in a SessionRequest object.
#
# The process starts when someone creates a SessionRequest object with an
# initial state of "draft".  The significant attributes of a SessionRequest
# that might be provided include:
#
#   - Whether the session is course-related.
#     If course related:
#       * Identity of the faculty
#       * Term in which the session will be taught
#       * Class section(s) attending the session
#       * Requested session times based on when the section meets
#     Otherwise
#       * Identity of the contact-person for the session
#       * Title of the session
#       * Requested session times
#       * Expected attendance
#   - Topics for the session
#   - Needed accommodations
#   - Whether a library location is needed
#   - Whether an evaluation is needed (and which one?)
#   - Whether registration is needed
#   - Possibly attachments with relevant information (e.g. a syllabus
#     for a course, or an assignment the participants will be doing)
#   - Further comments from the requester
#
# More editing may occur, but the next step is
# to submit the SessionRequest for scheduling, which changes its state to
# "requested".  More changes may be made, including the following:
#
#   - Reviewing the request and updating attributes
#   - Setting start-time and end-time
#   - Adding instructor(s)
#   - Adding a room (or marking not needed)
#   - Adding an evaluation (or marking not needed)
#   - Adding a registration option (or marking not needed)
#
# Once the details are set, scheduling ends and the session is considered
# "scheduled".  The state of the request is changed to "scheduled" and a
# Session is created with all relevant information from the Session
# Request.  Later, details about the session might change, but there's
# no need to update the Session Request once it is scheduled.
#
# Auth:
#
# create a request: a known user
# edit a request: creator or role of instructor or higher
# submit a request: creator
# schedule a session:  ??
#
class SessionRequest < ApplicationRecord
  attr_accessor :requested_by, :title, :contact_person, :accommodations, :expected_attendance,
                :library_location_needed, :evaluation_needed, :registration_needed, :requested_times, :topics,
                :course_related, :class_sections
  attr_reader :state

  def initialize(attribute_hash = {})
    @state = 'draft'
    self.requested_by             = attribute_hash[:requested_by]
    self.contact_person           = attribute_hash[:contact_person]
    self.title                    = attribute_hash[:title]
    self.course_related           = attribute_hash[:course_related]
    self.expected_attendance      = attribute_hash[:expected_attendance]
    self.accommodations           = attribute_hash[:accommodations]
    self.library_location_needed  = attribute_hash[:library_location_needed]
    self.evaluation_needed        = attribute_hash[:evaluation_needed]
    self.registration_needed      = attribute_hash[:registration_needed]
    if attribute_hash.has_key?(:requested_times) && ! attribute_hash[:requested_times].nil?
      self.requested_times = attribute_hash[:requested_times]&.map do |value|
        if value.date && value.start_time && value.end_time
          TimeRange.new(
              value.date.strftime("%Y-%m-%d"),
              value.start_time.strftime("%I:%M%p"),
              value.end_time.strftime("%I:%M%p")
          )
        end
      end.compact
    end
    self.topics = attribute_hash[:topics]&.dup
    self.class_sections = attribute_hash[:class_sections]&.dup
  end

  def submitted
    @state = 'requested'
  end

  def draft?
    @state == 'draft'
  end

  def to_h
    {
      requested_by: requested_by,
      contact_person: contact_person,
      course_related: course_related,
      title: title,
      expected_attendance: expected_attendance,
      accommodations: accommodations,
      library_location_needed: library_location_needed,
      evaluation_needed: evaluation_needed,
      registration_needed: registration_needed,
      requested_times: requested_times,
      topics: topics,
      class_sections: class_sections,
      state: state
    }
  end
end