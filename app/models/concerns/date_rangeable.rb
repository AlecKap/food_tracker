module DateRangeable
  extend ActiveSupport::Concern

  class_methods do
    def start_of_day
      DateTime.current.beginning_of_day
    end

    def end_of_day
      DateTime.current.end_of_day
    end
  end
end
