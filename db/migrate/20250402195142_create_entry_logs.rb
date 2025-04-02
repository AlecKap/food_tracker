class CreateEntryLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :entry_logs do |t|
      t.date :date
      t.string :type
      t.string :name
      t.integer :calories
      t.integer :protein
      t.integer :added_sugars
      t.integer :total_sugars
      t.integer :carbs

      t.timestamps
    end
  end
end
