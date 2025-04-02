class RenameTypeToMealTypeInEntryLogs < ActiveRecord::Migration[8.0]
  def change
    rename_column :entry_logs, :type, :meal_type
  end
end
