class EntryLog < ApplicationRecord
  belongs_to :user
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
    if date.present? && date > DateTime.current
      errors.add(:date, "can't be in the future")
    end
  end

  def self.formatted_date
    DateTime.current.strftime("%a %b %-d, %Y %-l:%M%P")
  end

  def formatted_date
    date.strftime("%a %b %-d, %Y %-l:%M%P")
  end

  def self.total_calories
    where(date: Date.today.in_time_zone).sum(:calories)
  end

  def self.total_protein
    where(date: Date.today.in_time_zone).sum(:protein)
  end

  def self.total_added_sugars
    where(date: Date.today.in_time_zone).sum(:added_sugars)
  end

  def self.total_daily_sugars
    where(date: Date.today.in_time_zone).sum(:total_sugars)
  end

  def self.total_carbs
    where(date: Date.today.in_time_zone).sum(:carbs)
  end

  def self.total_meals_today
    where(date: Date.today.in_time_zone).count
  end

  def self.newest_first
    order(date: :desc)
  end
end
