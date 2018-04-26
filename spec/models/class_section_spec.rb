# spec/models/class_section_spec.rb

require_relative '../spec_helper'

require_relative '../../app/models/class_section'

RSpec.describe ClassSection do
  describe "#new" do
    it "accepts four parameters representing a term, subject, course number and section number" do
      expect { ClassSection.new("FA 2018", "CHEM", "325", "001") }.not_to raise_error
    end
  end

  describe "#academic_term" do
    it "returns the value for academic_term given as the first parameter to the constructor" do
      class_section = ClassSection.new("Fall 2018", "CHEM", "325", "001")
      expect(class_section.academic_term).to eq "FA 2018"
    end
  end

  describe "#subject" do
    it "returns the value for subject given as the second parameter to the constructor" do
      class_section = ClassSection.new("Fall 2018", "CHEM", "325", "001")
      expect(class_section.subject).to eq "CHEM"
    end
  end

  describe "#course_number" do
    it "returns the value for course_number given as the third parameter to the constructor" do
      class_section = ClassSection.new("Fall 2018", "CHEM", "325", "001")
      expect(class_section.course_number).to eq "325"
    end
  end

  describe "#section_number" do
    it "returns the value for section_number given as the fourth parameter to the constructor" do
      class_section = ClassSection.new("Fall 2018", "CHEM", "325", "001")
      expect(class_section.section_number).to eq "001"
    end
  end
end
