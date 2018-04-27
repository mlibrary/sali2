# spec/use_cases/submit_request_spec.rb

require_relative '../spec_helper'

require_relative('../../app/use_cases/submit_request')

RSpec.describe SubmitRequest do

  let(:user) {
    double(User)
  }
  let(:persistence) {
    class_double("SessionRequest", {
        find: session_request
    })
  }
  let(:submit_request) {
    SubmitRequest.new(user, 1, persistence_class: persistence)
  }

  describe "#call" do
    context "where request is valid for submit and was created by user" do
      let(:session_request) {
        double("SessionRequest", {
            to_h: typical_session_request_attributes({requested_by: user, contact_person: user}),
            requested_by: user
        })
      }
      it "calls the submitted method on the session request" do
        expect(session_request).to receive :submitted
        submit_request.call
      end
    end

    context "where request is not valid for submit but was created by user" do
      let(:session_request) {
        double(SessionRequest, {
            to_h: {},
            requested_by: user
        })
      }
      it "does not call the #submitted method on session request" do
        expect(session_request).not_to receive :submitted
        submit_request.call
      end
    end

  end

  context "where request is valid for submit and was not created by user" do
    let(:another_user) {
      double("User")
    }
    let(:session_request) {
      double("SessionRequest", {
          to_h: typical_session_request_attributes({requested_by: another_user, contact_person: user}),
          requested_by: another_user
      })
    }
    it "throws an exception instead of calling the 'submitted' method on the session_request" do
      expect(session_request).not_to receive :submitted
      expect{ submit_request.call }.to raise_error(NotAuthorizedError)
    end
  end

  describe '#validate' do
    let(:user) {
      double("User")
    }
    let(:attribute_hash) do
      typical_session_request_attributes({requested_by: user, contact_person: user})
    end
    let (:session_request) do
      SessionRequest.new attribute_hash
    end
    let(:persistence) {
      class_double('SessionRequest', {
        find: session_request
      })
    }

    let(:operation) do
      SubmitRequest.new(user, 1, persistence_class: persistence)
    end
    let(:result) do
      operation.validate(session_request)
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

    describe "#class_sections" do
      context "with course_related false" do
        before { session_request.course_related = false }

        context "and class_sections not empty" do
          before { session_request.class_sections = [
             "EECS 280 001", "HISTORY 325 001"
          ]}
          it "reports failure" do
            expect(result.success?).to be false
          end
        end
        context "and class_sections empty" do
          before { session_request.class_sections = [] }
          it "reports success" do
            expect(result.success?).to be true
          end
        end
      end
      context "with course_related true" do
        before { session_request.course_related = true }

        context "and class_sections not empty" do
          before { session_request.class_sections = [
              "EECS 280 001", "HISTORY 325 001"
          ]}
          it "reports success" do
            expect(result.success?).to be true
          end
        end
        context "and class_sections empty" do
          before { session_request.class_sections = [] }
          it "reports failure" do
            expect(result.success?).to be false
          end
        end
      end
    end
  end
end
