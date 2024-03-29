# spec/policies/submit_request_policy_spec.rb

require_relative '../spec_helper'

require_relative '../../app/policies/submit_request_policy'

RSpec.describe SubmitRequestPolicy do
  describe ".new" do
    let(:user) {
      double('User')
    }
    let(:resource) {
      double('SessionRequest')
    }

    it "accepts a user and resource as params" do
      expect{ SubmitRequestPolicy.new(user, resource) }.not_to raise_exception
    end

    it "returns the user passed to the constructor" do
      policy = SubmitRequestPolicy.new(user, resource)
      expect(policy.user).to eq user
    end

    it "returns the resource passed to the constructor" do
      policy = SubmitRequestPolicy.new(user, resource)
      expect(policy.resource).to eq resource
    end
  end

  describe "#allowed?" do
    let(:user) {
      double("User")
    }
    let(:policy) {
      SubmitRequestPolicy.new(user, resource)
    }
    context "user is the creator" do
      let(:resource) {
        double("SessionRequest", {
            requested_by: user
        })
      }
      it "returns true" do
        expect(policy.allowed?).to be true
      end
    end

    context "user is not the creator" do
      let(:resource) {
        double("SessionRequest", {
            requested_by: double("User")
        })
      }
      it "returns false" do
        expect(policy.allowed?).not_to be true
      end
    end
  end

  describe "#authorize!" do
    let(:user) {
      double("User")
    }
    let(:policy) {
      SubmitRequestPolicy.new(user, resource)
    }

    context "with user authorized to take action" do
      let(:resource) {
        double("SubmitRequest", {
            requested_by: user
        })
      }
      it "does not raise an exception" do

        expect{ policy.authorize!(:allowed?) }.not_to raise_exception
      end
    end

    context "with user not authorized to take action" do
      let(:another_user) {

      }
      let(:resource) {
        double("SubmitRequest", {
            requested_by: another_user
        })
      }
      it "raises an exception" do

        expect{ policy.authorize!(:allowed?) }.to raise_error(NotAuthorizedError)
      end
    end
  end
end