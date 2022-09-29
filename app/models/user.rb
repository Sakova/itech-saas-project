class User < ApplicationRecord
  has_many :user_projects
  has_many :projects, through: :user_projects

  has_many :organization_users
  has_many :organizations, through: :organization_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
end
