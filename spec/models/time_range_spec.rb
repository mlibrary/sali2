# spec/models/time_range_spec.rb

require_relative '../spec_helper'

require_relative '../../app/models/time_range'

RSpec.describe TimeRange do

  describe "#new" do
    it "accepts three strings representing a date and two times of day as parameters" do
      expect { TimeRange.new("2018-06-01", "10:00am", "11:00 am") }.not_to raise_error
    end

    it "accepts times on a 24-hour clock if AP/PM is missing" do
      time_range = TimeRange.new("2018-06-01", "13:30", "15:45")
      expect(time_range.start_time).to eq Time.new(2018, 6, 1, 13, 30)
      expect(time_range.end_time).to eq Time.new(2018, 6, 1, 15, 45)
    end
  end

  describe "#date" do
    let(:time_range) {
      TimeRange.new("2018-06-01", "10:00am", "11:00am")
    }
    it "returns a Date object representing the date indicated by the contructor's first parameter" do
      expect(time_range.date).to be_a Date
      expect(time_range.date).to eq Date.new(2018, 6, 1)
    end
  end

  describe "#start_time" do
    let(:time_range) {
      TimeRange.new("2018-06-01", "2:00 pm", "03:00 pm")
    }
    it "returns a Time object representing the moment specified by the first and second constructor parameters" do
      expect(time_range.start_time).to be_a Time
      expect(time_range.start_time).to eq Time.new(2018, 6, 1, 14, 0, 0)
    end
  end

  describe "#end_time" do
    let(:time_range) {
      TimeRange.new("2018-06-01", "12:00pm", "1:30pm")
    }
    it "returns a Time object representing the moment specified by the first and third constructor parameters" do
      expect(time_range.end_time).to be_a Time
      expect(time_range.end_time).to eq Time.new(2018, 6, 1, 13, 30, 0)
    end
  end

  describe "#duration" do
    let(:time_range) {
      TimeRange.new("2018-06-01", "11:00am", "12:30pm")
    }
    it "returns an integer representing the time in minutes included in a time range" do
      expect(time_range.duration).to be_an Integer
      expect(time_range.duration).to eq 90
    end
  end
end