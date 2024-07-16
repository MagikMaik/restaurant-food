class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :dishes
  validates :name, presence: true
end
