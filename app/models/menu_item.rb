class MenuItem < ApplicationRecord
  validates :menu_name, presence: true, uniqueness: true
  validates :description, length: { maximum: 100 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
