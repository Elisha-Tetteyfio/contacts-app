class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :suburb
  has_one :city
  has_one :region

  attr_accessor :region_id, :city_id
end
