# spec/models/session_request_spec.rb

require 'spec_helper'

require_relative '../../app/models/session_request'
require_relative '../../app/models/academic_term'
require_relative '../../app/models/time_range'

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
describe SessionRequest do

  describe "#new" do
    it "accepts no parameters" do
      expect { SessionRequest.new }.not_to raise_error
    end

    it "accepts a hash as a parameter describing the requested session" do
      hash = {
        requested_by: "botimer",
        contact_person: "jimeng",
        title: "A valid title as a string",
        requested_times: [
          TimeRange.new("2018-04-10", "13:30", "15:45"),
          TimeRange.new("2018-04-17", "13:30", "15:45")
        ],
        expected_attendance: 30,
        accommodations: "Please provide materials in low contrast for one attendee.",
        library_location_needed: false,
        evaluation_needed: true,
        registration_needed: false,
        topics: [1, 4, 9, 16]
      }
      expect { SessionRequest.new(hash) }.not_to raise_error
    end
  end

  describe "#requested_by" do
    let(:hash) {
      {
          requested_by: "botimer",
          contact_person: "jimeng",
          title: "A valid title as a string",
          requested_times: [
              TimeRange.new("2018-04-10", "13:30", "15:45"),
              TimeRange.new("2018-04-17", "13:30", "15:45")
          ],
          expected_attendance: 30,
          accommodations: "Please provide materials in low contrast for one attendee.",
          library_location_needed: false,
          evaluation_needed: true,
          registration_needed: false,
          topics: [1, 4, 9, 16]
      }
    }
    subject(:session_request) { SessionRequest.new(hash) }

    it "returns a value of nil if requested_by is not set by constructor or setter" do
      expect(SessionRequest.new.requested_by).to be_nil
    end

    it "retrieves a value for the requested_by attribute stored by constructor" do
      expect(session_request.requested_by).to eq('botimer')
    end

    it "retrieves a value for the requested_by attribute stored by the setter" do
      session_request.requested_by = 'alphnumeric00'
      expect(session_request.requested_by).to eq('alphnumeric00')
    end

  end

  describe "#requested_by=" do
    let(:hash) {
      {
        requested_by: "botimer",
        contact_person: "jimeng",
        title: "A valid title as a string",
        requested_times: [
          TimeRange.new("2018-04-10", "13:30", "15:45"),
          TimeRange.new("2018-04-17", "13:30", "15:45")
        ],
        expected_attendance: 30,
        accommodations: "Please provide materials in low contrast for one attendee.",
        library_location_needed: false,
        evaluation_needed: true,
        registration_needed: false,
        topics: [1, 4, 9, 16]

      }
    }
    subject(:session_request) {
      SessionRequest.new(hash)
    }
    it "stores a value that can be retrieved using #requested_by accessor" do
      session_request.requested_by = "abcdef123"
      expect(session_request.requested_by).to eq('abcdef123')
    end
  end


end

