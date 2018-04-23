# spec/models/session_request_spec.rb

require 'rails_helper'

require_relative('../../app/use_cases/submit_request')

RSpec.describe SubmitRequest do

  # context "when there is no title" do
  #   before{ attribute_hash[:title] = nil }
  #   it "does not change the state of the SessionRequest object" do
  #     session_request.submitted
  #     expect(session_request.draft?).to be true
  #   end
  # end
  #
  # context "when there is no requested_by" do
  #   before{ attribute_hash[:requested_by] = nil }
  #   it "does not change the state of the SessionRequest object" do
  #     session_request.submitted
  #     expect(session_request.draft?).to be true
  #   end
  # end
  #
  # context "when there is no contact_person" do
  #   before{ attribute_hash[:contact_person] = nil }
  #   it "does not change the state of the SessionRequest object" do
  #     session_request.submitted
  #     expect(session_request.draft?).to be true
  #   end
  # end
  #
  # context "when there is no expected_attendance" do
  #   before{ attribute_hash[:expected_attendance] = nil }
  #   it "does not change the state of the SessionRequest object" do
  #     session_request.submitted
  #     expect(session_request.draft?).to be true
  #   end
  # end
  #
  # context "when there is no library_location_needed" do
  #   before{ attribute_hash[:library_location_needed] = nil }
  #   it "does not change the state of the SessionRequest object" do
  #     session_request.submitted
  #     expect(session_request.draft?).to be true
  #   end
  # end
  #
  # context "when there is no evaluation_needed" do
  #   before{ attribute_hash[:evaluation_needed] = nil }
  #   it "does not change the state of the SessionRequest object" do
  #     session_request.submitted
  #     expect(session_request.draft?).to be true
  #   end
  # end
  #
  # context "when there is no registration_needed" do
  #   before{ attribute_hash[:registration_needed] = nil }
  #   it "does not change the state of the SessionRequest object" do
  #     session_request.submitted
  #     expect(session_request.draft?).to be true
  #   end
  # end
  #
  # context "when there are no topics" do
  #   before{ attribute_hash[:topics] = nil }
  #   it "does not change the state of the SessionRequest object" do
  #     session_request.submitted
  #     expect(session_request.draft?).to be true
  #   end
  # end
  #
  # context "when there is no course_related" do
  #   before{ attribute_hash[:course_related] = nil }
  #   it "does not change the state of the SessionRequest object" do
  #     session_request.submitted
  #     expect(session_request.draft?).to be true
  #   end
  # end

  describe "#call" do
    let(:user) {
      double(User, {

      })
    }
    let(:persistence) {
      class_double(SessionRequest, {
          find: session_request
      })
    }
    let(:submit_request) {
      SubmitRequest.new(user, 1, persistence_class: persistence)
    }
    context "valid for submit" do
      let(:session_request) {
        double(SessionRequest, {
          to_h: {
            requested_by: "botimer",
            contact_person: "jimeng",
            title: 'title',
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
        })
      }
      it "calls the submitted method on the seesion request" do
        expect(session_request).to receive :submitted
        submit_request.call
      end
    end

    context "invalid for submit" do
      let(:session_request) {
        double(SessionRequest, to_h: {})
      }
      it "avoids calling the submitted method on session request" do
        expect(session_request).not_to receive :submitted
        submit_request.call
      end
    end

  end

end

