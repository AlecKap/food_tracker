class EntryLog < ApplicationRecord
  include DateRangeable

  belongs_to :user

  # Validations
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

  # Class Methods
  def self.past_two_days
    where(date: 2.days.ago..DateTime.current).order(date: :desc)
  end

  def self.past_week
    last_sunday = Date.today.sunday? ? Date.today : Date.today.beginning_of_week(:sunday)
    where(date: last_sunday..DateTime.current).order(date: :desc)
  end

  def self.past_month
    where(date: 1.month.ago..DateTime.current).order(date: :desc)
  end

  def self.formatted_date
    DateTime.current.strftime("%a %b %-d, %Y %-l:%M%P")
  end

  def self.total_calories
    where(date: start_of_day..end_of_day).sum(:calories)
  end

  def self.total_protein
    where(date: start_of_day..end_of_day).sum(:protein)
  end

  def self.total_added_sugars
    where(date: start_of_day..end_of_day).sum(:added_sugars)
  end

  def self.total_daily_sugars
    where(date: start_of_day..end_of_day).sum(:total_sugars)
  end

  def self.total_carbs
    where(date: start_of_day..end_of_day).sum(:carbs)
  end

  def self.total_meals_today
    where(date: start_of_day..end_of_day).count
  end

  def self.newest_first
    where(date: start_of_day..end_of_day).order(date: :desc)
  end

  # Instance Methods
  def formatted_date
    date.strftime("%a %b %-d, %Y %-l:%M%P")
  end
end
