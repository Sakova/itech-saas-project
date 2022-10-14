class User < ApplicationRecord
  has_many :user_project
  has_many :projects, through: :user_project
  has_many :organization_users
  has_many :organizations, through: :organization_users
  has_many :members
  has_many :projects, through: :members
  has_one :member

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  def to_s
    email
  end

  after_create do
    unless invited_by_id?
      customer = Stripe::Customer.create(email: self.email)
      update(stripe_customer_id: customer.id)
    end
  end
end
