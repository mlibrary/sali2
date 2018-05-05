# spec/clients/calendar_spec.rb

require_relative '../spec_helper'

require_relative '../../app/clients/calendar'

RSpec.describe Calendar do
  describe ".new" do
    let(:calendar_service) { double("CalendarService") }
    it "accepts a 'calendar_service' as a named parameter" do
      expect{ Calendar.new(calendar_service: calendar_service) }.not_to raise_exception
    end
  end

  describe "#calendar_service" do
    let(:calendar_service) { double("CalendarService") }

    it "returns the calendar_service passed to the constructor" do
      calendar = Calendar.new(calendar_service: calendar_service)
      expect(calendar.calendar_service).to eq calendar_service
    end
  end

  describe "#evaluation_assigned" do
    let(:request) { double("SessionRequest") }
    let(:calendar_service) { double("CalendarService", {
        add_or_update_instruction_calendar: true,
        add_or_update_location_calendar: true
    }) }
    let(:calendar) {
        Calendar.new(calendar_service: calendar_service)
    }

    it "accepts a SessionRequest object as a parameter" do
      allow(request).to receive(:scheduled_time)
      allow(request).to receive(:location)
      expect{ calendar.evaluation_assigned(request) }.not_to raise_exception
    end

    context "when request.scheduled_time and request.location are both set" do
      it "calls the calendar_service.add_or_update_instruction_calendar method" do
        allow(request).to receive(:scheduled_time).and_return("Any non-null value")
        allow(request).to receive(:location).and_return("Any non-null value")
        expect(calendar_service).to receive(:add_or_update_instruction_calendar)
        calendar.evaluation_assigned(request)
      end
      it "calls the calendar_service.add_or_update_location_calendar method" do
        allow(request).to receive(:scheduled_time).and_return("Any non-null value")
        allow(request).to receive(:location).and_return("Any non-null value")
        expect(calendar_service).to receive(:add_or_update_location_calendar)
        calendar.evaluation_assigned(request)
      end
    end

    context "when request.scheduled_time is set and request.location is not set" do
      it "calls the calendar_service.add_or_update_location_calendar method" do
        allow(request).to receive(:scheduled_time).and_return("Any non-null value")
        allow(request).to receive(:location)
        expect(calendar_service).to receive(:add_or_update_instruction_calendar)
        calendar.evaluation_assigned(request)
      end
      it "does not call the calendar_service.add_or_update_location_calendar method" do
        allow(request).to receive(:scheduled_time).and_return("Any non-null value")
        allow(request).to receive(:location)
        expect(calendar_service).not_to receive(:add_or_update_location_calendar)
        calendar.evaluation_assigned(request)
      end
    end

    context "when neither request.scheduled_time nor request.location is set" do
      it "does not call the calendar_service.add_or_update_instruction_calendar method" do
        allow(request).to receive(:scheduled_time)
        allow(request).to receive(:location)

      end
      it "does not call the calendar_service.add_or_update_location_calendar method" do
        allow(request).to receive(:scheduled_time)
        allow(request).to receive(:location)

      end
    end

    # add-or-update event in instruction-calendar (changes: description)
    # return unless room is set
    # add-or-update event in room-calendar (changes: description)
    # return unless scheduled-time is set

  end
end

