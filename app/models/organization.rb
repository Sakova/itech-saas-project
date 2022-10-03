class Organization < ApplicationRecord
  has_many :members, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :organization_users
  has_many :users, through: :organization_users

  validates :name, uniqueness: true, presence: true

  enum plan: %i[free premium]

  def self.create_new_organization(org_params)

    org = Organization.new(org_params)

    if org.valid?
      org.save
    else
      org = nil
    end
    return org
  end
end