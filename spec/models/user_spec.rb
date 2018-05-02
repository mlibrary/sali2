require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#new' do
    let(:attribute_hash) {
      {
          uniqname:   'uniqname',
          firstname:  'firstname',
          lastname:   'lastname',
          role:       'requester',
          unit:       'unit'
      }
    }
    it "accepts a hash as a parameter describing the attributes of the user" do
      expect { User.new(attribute_hash) }.not_to raise_error
    end

    it "creates a new User with active set to true" do
      expect(User.new(attribute_hash).active).to be true
    end

    it "sets uniqname to a value supplied in the attribute hash" do
      expect(User.new(attribute_hash).uniqname).to eq attribute_hash[:uniqname]
    end

    it "sets firstname to a value supplied in the attribute hash" do
      expect(User.new(attribute_hash).firstname).to eq attribute_hash[:firstname]
    end

    it "sets lastname to a value supplied in the attribute hash" do
      expect(User.new(attribute_hash).lastname).to eq attribute_hash[:lastname]
    end

    it "sets role to a value supplied in the attribute hash" do
      expect(User.new(attribute_hash).role).to eq attribute_hash[:role]
    end

    it "sets role to a default value ('requester') if no value is supplied in the attribute hash" do
      attribute_hash.delete(:role)
      expect(User.new(attribute_hash).role).to eq 'requester'
    end

    it "sets unit to a value supplied in the attribute hash" do
      expect(User.new(attribute_hash).unit).to eq attribute_hash[:unit]
    end
  end

  describe "#has_role?" do
    it "reports the role assigned in the constructor" do
      ['admin', 'scheduler', 'instructor', 'requester'].each do |role|
        user = User.new({
                            uniqname:   'uniqname',
                            firstname:  'firstname',
                            lastname:   'lastname',
                            role:       role,
                            unit:       'unit'
                        })
        expect(user.has_role?(role)).to be true
      end
    end
  end

  describe "#set_role" do
    it "sets role to the value passed as a parameter" do
      user = User.new({
                          uniqname:   'uniqname',
                          firstname:  'firstname',
                          lastname:   'lastname',
                          unit:       'unit'
                      })
      ['admin', 'scheduler', 'instructor', 'requester'].each do |role|
        expect(user.has_role?(role)).to be false
        user.set_role(role)
        expect(user.has_role?(role)).to be true
      end
    end
  end

  describe "#known?" do
    it "returns true if user is a known user" do

    end

    it "returns false if user is not a known user" do

    end
  end
end
