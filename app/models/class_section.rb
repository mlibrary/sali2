require_relative "./academic_term"

class ClassSection
  def initialize(academic_term, subject, course_number, section_number)
    @academic_term = AcademicTerm.new(academic_term).to_s
    @subject = subject
    @course_number = course_number
    @section_number = section_number
  end

  attr_reader :academic_term, :subject, :course_number, :section_number
  attr_accessor :class_number, :class_name
end