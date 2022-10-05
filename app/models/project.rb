class Project < ApplicationRecord
  has_many :user_project
  has_many :users, through: :user_project
  belongs_to :organization
  validates :title, uniqueness: true
  has_many :artifacts, dependent: :destroy

  def self.by_user_plan_and_organization(org_id, user)
    org = Organization.find(org_id)
    if org.plan == 'premium'
      if user.admin?
        org.projects
      else
        user.projects.where(organization_id: org.id)
      end
    else
      if user.admin
        org.projects.order(:id).limit(1)
      else
        user.projects.where(organization_id: org.id).order(:id).limit(1)
      end
    end
  end
end
