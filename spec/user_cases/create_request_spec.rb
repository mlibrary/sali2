# spec/use_cases/create_request_spec.rb

require_relative '../spec_helper'

require_relative('../../app/use_cases/create_request')

RSpec.describe CreateRequest do
  let(:user) {
    double("User")
  }
  let(:attribute_hash) {
    typical_session_request_attributes({
        requested_by: user,
        contact_person: user
    })
  }
  describe "#new" do
    it "accepts parameters "
  end

end
