class Project < ApplicationRecord
  has_many :user_project
  has_many :users, through: :user_project
  has_many :members
  has_many :users, through: :members
  belongs_to :organization
  validates :expected_completion_date, presence: true
  validates :title, presence: true, length: {minimum: 3, maximum: 25}
  validates :details, presence: true, length: {minimum: 5, maximum: 125}
  validate :expected_completion_date_greater_then_today
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

  def self.set_project_check(project_id, organization)
    if organization.plan == 'free'
      return organization.projects[0]
    else
      return organization.projects.find(project_id)
    end
  end

  def expected_completion_date_greater_then_today
    unless !expected_completion_date.present? || expected_completion_date > Time.now
      errors.add(:expected_completion_date, "must be greater than today")
    end
  end
end
