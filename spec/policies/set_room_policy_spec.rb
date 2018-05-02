# spec/policies/set_room_policy_spec.rb

require_relative '../spec_helper'

require_relative '../../app/policies/set_room_policy'

RSpec.describe SetRoomPolicy do
  describe ".new" do
    let(:user) {
      double('User')
    }
    let(:resource) {
      double('SessionRequest')
    }

    it "accepts a user and resource as params" do
      expect{ SetRoomPolicy.new(user, resource) }.not_to raise_exception
    end

    it "returns the user passed to the constructor" do
      policy = SetRoomPolicy.new(user, resource)
      expect(policy.user).to eq user
    end

    it "returns the resource passed to the constructor" do
      policy = SetRoomPolicy.new(user, resource)
      expect(policy.resource).to eq resource
    end
  end

  describe "#allowed?" do
    let(:user) {
      double("User")
    }
    let(:resource) {
      double("SessionRequest")
    }
    let(:policy) {
      SetRoomPolicy.new(user, resource)
    }

    context "when user has requester role" do
      it "returns false" do
        allow(user).to receive(:has_role?) { |role| role == 'requester' }
        expect(policy.allowed?).to be false
      end
    end

    context "when user has room role" do
      it "returns false" do
        allow(user).to receive(:has_role?) { |role| role == 'room' }
        expect(policy.allowed?).to be false
      end
    end

    context "when user has scheduler role" do
      it "returns true" do
        allow(user).to receive(:has_role?) { |role| role == 'scheduler' }
        expect(policy.allowed?).to be true
      end
    end

    context "when user has admin role" do
      it "returns true" do
        allow(user).to receive(:has_role?) { |role| role == 'admin' }
        expect(policy.allowed?).to be true
      end
    end
  end

  describe "#authorize!" do
    let(:user) { double("User") }
    let(:resource) { double("SetRoom") }
    let(:policy) { SetRoomPolicy.new(user, resource) }

    context "when user has requester role" do
      it "raises an exception" do
        allow(user).to receive(:has_role?) { |role| role == 'requester' }
        expect{ policy.authorize!(:allowed?) }.to raise_error(NotAuthorizedError)
      end
    end

    context "when user has room role" do
      it "raises an exception" do
        allow(user).to receive(:has_role?) { |role| role == 'room' }
        expect{ policy.authorize!(:allowed?) }.to raise_error(NotAuthorizedError)
      end
    end

    context "when user has scheduler role" do
      it "does not raise an exception" do
        allow(user).to receive(:has_role?) { |role| role == 'scheduler' }
        expect{ policy.authorize!(:allowed?) }.not_to raise_exception
      end
    end

    context "when user has admin role" do
      it "does not raise an exception" do
        allow(user).to receive(:has_role?) { |role| role == 'admin' }
        expect{ policy.authorize!(:allowed?) }.not_to raise_exception
      end
    end
  end
end