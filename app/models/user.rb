class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :contacts
  has_one :user_role
  has_many :roles, through: :user_role

  def super_admin?
    roles.where(role_code: "SA").present?
  end
end
