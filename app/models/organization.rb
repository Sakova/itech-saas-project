class Organization < ApplicationRecord
  has_many :organization_users
  has_many :users, through: :organization_users
  enum plan: %i[free premium]
end