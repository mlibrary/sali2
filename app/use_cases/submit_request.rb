# app/models/use_cases/submit_request.rb

require 'dry-validation'

class SubmitRequest
  attr_reader :user, :request_id

  def initialize(user, request_id, persistence_class: SessionRequest)
    @user = user
    @request_id = request_id
    @persistence_class = persistence_class
  end

  def call
    # retrieve obj
    request = @persistence_class.find(@request_id)

    # check checkpoint policies
    policy = SubmitRequestPolicy.new(@user, request)
    policy.authorize! :allowed?

    # check validations
    @result = validate(request)

    # call SessionRequest#submitted
    request.submitted if @result.success?
  end

  def errors
    @result.errors || {}
  end

  def success?
    raise Exception() unless @result
    @result.success?
  end

  def failure?
    raise Exception() unless @result
    @result.failure?
  end

  # private

  def validate(request)
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
      required(:class_sections).maybe(:array?)

      rule(class_sections_empty_when_not_course_related: [:course_related, :class_sections]) do |course_related, class_sections|
        course_related.false? > (class_sections.nil?.or(class_sections.empty?))
      end
      rule(class_sections_filled_when_course_related: [:course_related, :class_sections]) do |course_related, class_sections|
        course_related.true? > (class_sections.filled?)
      end
     end

    schema.call(request.to_h)
  end

end