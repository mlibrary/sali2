require 'dry-validation'

module ModelValidations
  def self.validate_to_complete_scheduling(hash)

  end

  def self.validate_to_submit_for_scheduling(hash)
    schema = Dry::Validation.Form do
      required(:title).filled
      required(:course_related).filled
      required(:requested_by).filled
      required(:contact_person).filled
      required(:expected_attendance).filled
      required(:library_location_needed).filled
      required(:evaluation_needed).filled
      required(:registration_needed).filled
      required(:requested_times).filled
      required(:topics).filled

      rule(class_sections_maybe: [:course_related, :class_sections]) do |course_related, class_sections|
        course_related.true?.then class_sections.filled?
        course_related.false?.then class_sections.none?
      end
    end
    schema.call(hash)
  end
  def self.validate_to_complete_scheduling(hash)
    schema = Dry::Validation.Form do
      required(:title).filled

    end
    schema.call(hash)
  end
end