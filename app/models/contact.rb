class Contact < ApplicationRecord
  before_save :format_input

  belongs_to :user
  belongs_to :suburb
  has_one :city
  has_one :region

  attr_accessor :region_id, :city_id

  validates :fname, presence: true 
  validates :lname, presence: true
  validates :phone, presence: true
  validates :suburb, presence: true

  private

  def format_input
    self.fname = fname.strip.capitalize
    self.lname = lname.strip.capitalize
    self.phone = phone.strip
    self.email = email.strip
  end

end
