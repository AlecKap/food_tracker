class Meal < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :calories, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2000 }
  validates :protein, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 500 }
  validates :added_sugars, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 200 }
  validates :total_sugars, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 200 }
  validates :carbs, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 500 }
end
