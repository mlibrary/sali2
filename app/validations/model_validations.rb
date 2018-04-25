require 'dry-validation'

module ModelValidations

  def self.validate_to_complete_scheduling(hash)
    schema = Dry::Validation.Form do
      required(:title).filled

    end
    schema.call(hash)
  end
end