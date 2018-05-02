# spec/policies/create_request_policy_spec.rb

require_relative '../spec_helper'

require_relative '../../app/policies/create_request_policy'

RSpec.describe CreateRequestPolicy do
  describe ".new" do
    let(:user) {
      double('User')
    }

    it "accepts a user as its sole param" do
      expect{ CreateRequestPolicy.new(user) }.not_to raise_exception
    end

    it "returns the user passed to the constructor" do
      policy = CreateRequestPolicy.new(user)
      expect(policy.user).to eq user
    end

  end

  describe "#allowed?" do
    let(:user) { double("User") }
    let(:policy) { CreateRequestPolicy.new(user) }
    it "returns true" do
      expect(policy.allowed?).to be true
    end
   end
end