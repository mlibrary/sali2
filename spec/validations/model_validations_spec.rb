# spec/models/session_request_spec.rb

require_relative '../spec_helper'

# require_relative '../../app/models/academic_term'
# require_relative '../../app/models/time_range'
require_relative '../../app/validations/model_validations'

RSpec.describe ModelValidations do
  describe '#validate_to_complete_scheduling' do

  end


  describe '#validate_to_submit_for_scheduling' do
    let(:attribute_hash) do
      {
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
    end
    let (:session_request) do
      SessionRequest.new attribute_hash
    end

    let(:result) do
      ModelValidations.validate_to_submit_for_scheduling(session_request.to_h)
    end

    context "when required attributes are set" do
      it "reports no failure" do
        expect(result.failure?).to be false
      end
      it "provides no messages" do
        expect(result.messages).to be_empty
      end
    end

    describe "#title" do
      before { session_request.title = nil }

      it "reports failure if title is missing" do
        expect(result.failure?).to be true
      end
      it "provides a message if the title is missing" do
        expect(result.messages[:title]).to include "must be filled"
      end
    end

    describe "#course_related" do
      before { session_request.course_related = nil }

      it "reports failure if course_related is missing" do
        expect(result.failure?).to be true
      end
      it "provides a message if the course_related is missing" do
        expect(result.messages[:course_related]).to include "must be filled"
      end
    end

    describe "#requested_by" do
      before { session_request.requested_by = nil }

      it "reports failure if requested_by is missing" do
        expect(result.failure?).to be true
      end
      it "provides a message if the requested_by is missing" do
        expect(result.messages[:requested_by]).to include "must be filled"
      end
    end

    describe "#contact_person" do
      before { session_request.contact_person = nil }

      it "reports failure if contact_person is missing" do
        expect(result.failure?).to be true
      end
      it "provides a message if the contact_person is missing" do
        expect(result.messages[:contact_person]).to include "must be filled"
      end
    end

    describe "#expected_attendance" do
      before { session_request.expected_attendance = nil }

      it "reports failure if expected_attendance is missing" do
        expect(result.failure?).to be true
      end
      it "provides a message if the expected_attendance is missing" do
        expect(result.messages[:expected_attendance]).to include "must be filled"
      end
    end

    describe "#library_location_needed" do
      before { session_request.library_location_needed = nil }

      it "reports failure if library_location_needed is missing" do
        expect(result.failure?).to be true
      end
      it "provides a message if the library_location_needed is missing" do
        expect(result.messages[:library_location_needed]).to include "must be filled"
      end
    end

    describe "#evaluation_needed" do
      before { session_request.evaluation_needed = nil }

      it "reports failure if evaluation_needed is missing" do
        expect(result.failure?).to be true
      end
      it "provides a message if the evaluation_needed is missing" do
        expect(result.messages[:evaluation_needed]).to include "must be filled"
      end
    end

    describe "#registration_needed" do
      before { session_request.registration_needed = nil }

      it "reports failure if registration_needed is missing" do
        expect(result.failure?).to be true
      end
      it "provides a message if the registration_needed is missing" do
        expect(result.messages[:registration_needed]).to include "must be filled"
      end
    end

    describe "#requested_times" do
      before { session_request.requested_times = [] }

      it "reports failure if requested_times if nil or empty" do
        expect(result.failure?).to be true
      end
      it "provides a message if the requested_times is nil or empty" do
        expect(result.messages[:requested_times]).to include "must be filled"
      end
    end

    describe "#topics" do
      before { session_request.topics = [] }

      it "reports failure if topics is nil or empty" do
        expect(result.failure?).to be true
      end
      it "provides a message if the topics is nil or empty" do
        expect(result.messages[:topics]).to include "must be filled"
      end
    end
  end
end