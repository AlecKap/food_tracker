json.extract! entry_log, :id, :date, :type, :name, :calories, :protein, :added_sugars, :total_sugars, :carbs, :created_at, :updated_at
json.url entry_log_url(entry_log, format: :json)
