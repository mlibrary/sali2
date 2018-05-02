# spec/policies/update_request_policy_spec.rb

require_relative '../spec_helper'

require_relative '../../app/policies/update_request_policy'

RSpec.describe UpdateRequestPolicy do
  describe ".new" do
    let(:user) {
      double('User')
    }
    let(:resource) {
      double('SessionRequest')
    }

    it "accepts a user and resource as params" do
      expect{ UpdateRequestPolicy.new(user, resource) }.not_to raise_exception
    end

    it "returns the user passed to the constructor" do
      policy = UpdateRequestPolicy.new(user, resource)
      expect(policy.user).to eq user
    end

    it "returns the resource passed to the constructor" do
      policy = UpdateRequestPolicy.new(user, resource)
      expect(policy.resource).to eq resource
    end
  end

  describe "#allowed?" do
    let(:policy) {
      UpdateRequestPolicy.new(user, resource)
    }
    context "when user is the requester" do
      let(:user) {
        double("User", { role: :requester })
      }
      let(:resource) {
        double("SessionRequest", { requested_by: user })
      }
      it "returns true" do
        allow(user).to receive(:has_role?) { |role| role == 'requester' }
        expect(policy.allowed?).to be true
      end
    end

    context "when user has instructor role" do
      let(:user) {
        double("User")
      }
      let(:resource) {
        double("SessionRequest", { requested_by: double("User") })
      }
      it "returns true" do
        allow(user).to receive(:has_role?) { |role| role == 'instructor' }
        expect(policy.allowed?).to be true
      end
    end

    context "when user has scheduler role" do
      let(:user) {
        double("User")
      }
      let(:resource) {
        double("SessionRequest", { requested_by: double("User") })
      }
      it "returns true" do
        allow(user).to receive(:has_role?) { |role| role == 'scheduler' }
        expect(policy.allowed?).to be true
      end
    end

    context "when user has admin role" do
      let(:user) {
        double("User")
      }
      let(:resource) {
        double("SessionRequest", { requested_by: double("User") })
      }
      it "returns true" do
        allow(user).to receive(:has_role?) { |role| role == 'admin' }
        expect(policy.allowed?).to be true
      end
    end

    context "when user is not the creator and has requester role" do
      let(:resource) {
        double("SessionRequest", { requested_by: double("User") })
      }
      let(:user) {
        double("User", { role: :requester })
      }
      it "returns false" do
        allow(user).to receive(:has_role?) { |role| role == 'requester' }
        expect(policy.allowed?).to be false
      end
    end
  end

  describe "#authorize!" do
    let(:user) {
      double("User")
    }
    let(:another_user) {
      double("user")
    }
    let(:policy) {
      UpdateRequestPolicy.new(user, resource)
    }

    context "when user is the requester" do
      let(:resource) {
        double("UpdateRequest", {
            requested_by: user
        })
      }
      it "does not raise an exception" do
        allow(user).to receive(:has_role?) { |role| role == 'requester' }
        expect{ policy.authorize!(:allowed?) }.not_to raise_exception
      end
    end

    context "when user has instructor role" do
      let(:resource) {
        double("UpdateRequest", {
            requested_by: another_user
        })
      }
      it "does not raise an exception" do
        allow(user).to receive(:has_role?) { |role| role == 'instructor' }
        expect{ policy.authorize!(:allowed?) }.not_to raise_exception
      end
    end

    context "when user has scheduler role" do
      let(:resource) {
        double("UpdateRequest", {
            requested_by: another_user
        })
      }
      it "does not raise an exception" do
        allow(user).to receive(:has_role?) { |role| role == 'scheduler' }
        expect{ policy.authorize!(:allowed?) }.not_to raise_exception
      end
    end

    context "when user has admin role" do
      let(:resource) {
        double("UpdateRequest", {
            requested_by: another_user
        })
      }
      it "does not raise an exception" do
        allow(user).to receive(:has_role?) { |role| role == 'admin' }
        expect{ policy.authorize!(:allowed?) }.not_to raise_exception
      end
    end

    context "with user is a requester but not the requester" do
      let(:resource) {
        double("UpdateRequest", {
            requested_by: another_user
        })
      }
      it "raises an exception" do
        allow(user).to receive(:has_role?) { |role| role == 'requester' }
        expect{ policy.authorize!(:allowed?) }.to raise_error(NotAuthorizedError)
      end
    end
  end
end