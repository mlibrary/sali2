# spec/models/session_request_spec.rb

require_relative '../rails_helper'

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
RSpec.describe SessionRequest do

  describe "#new" do
    let(:attribute_hash) do
      {
        requested_by: "botimer",
        contact_person: "jimeng",
        title: "A valid title as a string",
        expected_attendance: 30,
        course_related: true,
        accommodations: "Please provide materials in low contrast for one attendee.",
        library_location_needed: false,
        evaluation_needed: true,
        registration_needed: false,
        topics: [1, 4, 9, 16],
        requested_times: [
          TimeRange.new("2018-04-10", "13:30", "15:45"),
          TimeRange.new("2018-04-17", "13:30", "15:45")
        ]
      }
    end
    let (:session_request) do
      SessionRequest.new attribute_hash
    end


    it "accepts no parameters" do
      expect { SessionRequest.new }.not_to raise_error
    end

    it "accepts a hash as a parameter describing the requested session" do
      expect { SessionRequest.new(attribute_hash) }.not_to raise_error
    end

    it "creates a new SessionRequest with a state of 'draft'" do
      expect(session_request.state).to eq "draft"
    end

    it "sets requested_by to a value supplied in the attribute hash" do
      expect(session_request.requested_by).to eq attribute_hash[:requested_by]
    end
    it "sets contact_person to a value supplied in the attribute hash" do
      expect(session_request.contact_person).to eq attribute_hash[:contact_person]
    end
    it "sets title to a value supplied in the attribute hash" do
      expect(session_request.title).to eq attribute_hash[:title]
    end
    it "sets expected_attendance to a value supplied in the attribute hash" do
      expect(session_request.expected_attendance).to eq attribute_hash[:expected_attendance]
    end
    it "sets accommodations to a value supplied in the attribute hash" do
      expect(session_request.accommodations).to eq attribute_hash[:accommodations]
    end
    it "sets library_location_needed to a value supplied in the attribute hash" do
      expect(session_request.library_location_needed).to eq attribute_hash[:library_location_needed]
    end
    it "sets evaluation_needed to a value supplied in the attribute hash" do
      expect(session_request.evaluation_needed).to eq attribute_hash[:evaluation_needed]
    end
    it "sets registration_needed to a value supplied in the attribute hash" do
      expect(session_request.registration_needed).to eq attribute_hash[:registration_needed]
    end
    it "sets requested_times to an ordered list of TimeRange objects as supplied in the attribute hash" do
      expect(session_request.requested_times).to be_an Array
      requested_times = session_request.requested_times
      attribute_hash[:requested_times].each_with_index {|value, index|
        expect(value).to be_a TimeRange
        expect(value).to eq attribute_hash[:requested_times][index]
      }
    end
  end

  describe "#draft?" do
    it "is true when state is draft" do
      request = SessionRequest.new
      allow(request).to receive(:state).and_return('draft')
      expect(request.draft?).to eq true
    end

  end

  describe "#requested?" do

  end

  describe "#scheduled?" do

  end

  describe "#submitted" do
    let(:attribute_hash) do
      {
          requested_by: "botimer",
          contact_person: "jimeng",
          title: "A valid title as a string",
          expected_attendance: 30,
          course_related: true,
          accommodations: "Please provide materials in low contrast for one attendee.",
          library_location_needed: false,
          evaluation_needed: true,
          registration_needed: false,
          topics: [1, 4, 9, 16],
          requested_times: [
              TimeRange.new("2018-04-10", "13:30", "15:45"),
              TimeRange.new("2018-04-17", "13:30", "15:45")
          ]
      }
    end
    let (:session_request) do
      SessionRequest.new attribute_hash
    end

    it "changes the state to 'requested'" do
      session_request.submitted
      expect(session_request.state).to eq 'requested'
    end

  end

end

