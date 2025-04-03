class EntryLog < ApplicationRecord
  # class methods
  validates :name, presence: true, length: { maximum: 50 }
  validates :meal_type, presence: true, inclusion: { in: %w[Breakfast Lunch Dinner Snack] }
  validates :calories, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :protein, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :added_sugars, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :total_sugars, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :carbs, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :date, presence: true
  validate :date_cannot_be_in_the_future

  def date_cannot_be_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end

  def self.formatted_date
    Date.today.strftime("%A %B %-d, %Y")
  end

  def self.total_calories
    where(date: Date.today).sum(:calories)
  end

  def self.total_protein
    where(date: Date.today).sum(:protein)
  end

  def self.total_added_sugars
    where(date: Date.today).sum(:added_sugars)
  end

  def self.total_daily_sugars
    where(date: Date.today).sum(:total_sugars)
  end

  def self.total_carbs
    where(date: Date.today).sum(:carbs)
  end

  def self.total_meals_today
    where(date: Date.today).count
  end
end
