class ChangeDateColumnTypeInEntryLogs < ActiveRecord::Migration[8.0]
  def change
    change_column :entry_logs, :date, :datetime
  end
end
