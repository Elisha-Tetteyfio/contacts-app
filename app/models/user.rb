class User < ApplicationRecord
  before_save :format_input
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :contacts
  has_one :user_role
  has_one :role, through: :user_role

  validates :fname, presence: true 
  validates :phone, presence: true
  validates :email, presence: true
  validates :password, presence: true

  def super_admin?
    # roles.where(role_code: "SA").present?
    role.role_code == "SA"
  end

  private

  def format_input
    self.fname = fname.strip.capitalize
    self.lname = lname.strip.capitalize
    self.phone = phone.strip
    self.email = email.strip
  end

end
