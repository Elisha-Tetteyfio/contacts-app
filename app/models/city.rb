class City < ApplicationRecord
  belongs_to :region
  belongs_to :user
  has_many :suburbs
end
