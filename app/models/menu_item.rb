class MenuItem < ApplicationRecord
  validates :menu_name, presence: true, uniqueness: true
  validates :description, length: { maximum: 100 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :order, presence: true, uniqueness: true, 
                    numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 1000 }
end
