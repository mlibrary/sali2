# spec/models/academic_term_spec.rb

require_relative '../spec_helper'

require_relative '../../app/models/academic_term'

RSpec.describe AcademicTerm do

  describe "#new" do
    it "accepts a string as a parameter representing a term and year" do
      expect { AcademicTerm.new("FA 2018") }.not_to raise_error
    end

    it "accepts no parameters" do
      expect { AcademicTerm.new }.not_to raise_error
    end
  end

  describe "#semester" do
    it "returns a valid term code if no parameters are provided in the constructor" do
      expect(AcademicTerm.new.semester).to match /FA|SP|SS|SU|WI/
    end

    it "returns FA if parameter starting with FA or FALL (any case) is provided to constructor" do
      [
        ' fa 2018 ', 'Fa   2018 ', 'fA 2018 ', "FA2018",
        ' fall 2018 ', ' falL 2018 ', ' faLl 2018 ', ' faLL 2018 ',
        ' fAll 2018 ', ' fAlL 2018 ', ' fALl 2018 ', ' fALL 2018 ',
        ' Fall 2018 ', ' FalL 2018 ', ' FaLl 2018 ', ' FaLL 2018 ',
        ' FAll 2018 ', ' FAlL 2018 ', ' FALl 2018 ', ' FALL 2018 '
      ].each do |param|
        expect(AcademicTerm.new(param).semester).to eq "FA"
      end
    end

    it "returns SP if parameter starting with SP or Spring (any case) is provided to constructor" do
      [
          ' sp 2018 ', 'sP   2018 ', 'Sp 2018 ', "SP2018",
          ' spring 2018 ', ' Spring 2018 ', ' SPring 2018 ', ' SPRING 2018 '
      ].each do |param|
        expect(AcademicTerm.new(param).semester).to eq "SP"
      end
    end

    it "returns SS if parameter starting with SS (any case) is provided to constructor" do
      [
          ' ss 2018 ', 'SS   2018 ', 'sS 2018 ', "Ss 2018"
      ].each do |param|
        expect(AcademicTerm.new(param).semester).to eq "SS"
      end
    end

    it "returns SS if parameter starting with Spring-Summer (any case) is provided to constructor" do
      [
          'Spring-Summer 2018 ', "SPRING-Summer 2018",
          ' spring-summer 2018 ', ' SPRING-SUMMER 2018 '
      ].each do |param|
        expect(AcademicTerm.new(param).semester).to eq "SS"
      end
    end

    it "returns SS if parameter starting with Spring/Summer (any case) is provided to constructor" do
      [
          "Spring/Summer 2018", "spring/summer 2018",
          "SPRING/SUMMER 2018", "SPRING/summer 2018"
      ].each do |param|
        expect(AcademicTerm.new(param).semester).to eq "SS"
      end
    end

    it "returns SU if parameter starting with SU or SUMMER (any case) is provided to constructor" do
      [
        ' su 2018 ', 'Su   2018 ', 'sU 2018 ', "SU2018",
        ' summer 2018 ', ' Summer 2018 ', ' SummeR 2018 ', ' SummER 2018 ',
        ' suMMer 2018 ', ' SUmmER 2018 ', ' SUMmer 2018 ', ' SuMmEr 2018 ',
        ' SuMMeR 2018 ', ' sUMMER 2018 ', ' sUMMEr 2018 ', ' sUMMer 2018 ',
        ' suMmeR 2018 ', ' sUmmer 2018 ', ' SUmmer 2018 ', ' SUMMER 2018 '
      ].each do |param|
        expect(AcademicTerm.new(param).semester).to eq "SU"
      end
    end

    it "returns FA if parameter starting with FA or FALL (any case) is provided to constructor" do
      [
        ' wi 2018 ', 'wI   2018 ', 'Wi 2018 ', "WI 2018",
        ' winter 2018 ', ' winteR 2018 ', ' wintER 2018 ', ' winTER 2018 ',
        ' wiNter 2018 ', ' wInTER 2018 ', ' WINter 2018 ', ' WINTER 2018 '
      ].each do |param|
        expect(AcademicTerm.new(param).semester).to eq "WI"
      end
    end
  end

  describe "#year" do
    it "returns the four-digit year if parameter ending with a four-digit year is provided to constructor" do
      (2007..2027).each do |number|
        expect(AcademicTerm.new("FA #{number}").year).to eq number
      end
    end
  end

  describe "#to_s" do
    it "returns a string containing one of FA, SP, SS, SU or WI followed by a four-digit number representing the year" do
      expect(AcademicTerm.new("Fall 2018").to_s).to eq "FA 2018"
      expect(AcademicTerm.new("SPRING 2018").to_s).to eq "SP 2018"
      expect(AcademicTerm.new("spring-Summer 2018").to_s).to eq "SS 2018"
      expect(AcademicTerm.new("summer 2018").to_s).to eq "SU 2018"
      expect(AcademicTerm.new("winter 2018").to_s).to eq "WI 2018"
    end
  end
end
