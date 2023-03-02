class Region < ApplicationRecord
  belongs_to :user
  has_many :cities
end
