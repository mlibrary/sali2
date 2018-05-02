class User < ApplicationRecord
  attr_reader :uniqname, :firstname, :lastname, :unit,
              :active, :role, :created_at, :updated_at

  def initialize(attributes={})
    @uniqname = attributes[:uniqname]
    @firstname = attributes[:firstname]
    @lastname = attributes[:lastname]
    @unit = attributes[:unit]
    @role = attributes[:role] || 'requester'
    @active = true
  end

  def has_role? (role)
    @role == role
  end

  def set_role(role)
    @role = role
  end

end
