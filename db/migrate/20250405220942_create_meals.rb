class CreateMeals < ActiveRecord::Migration[8.0]
  def change
    create_table :meals do |t|
      t.string :name
      t.integer :calories
      t.integer :protein
      t.integer :added_sugars
      t.integer :total_sugars
      t.integer :carbs
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
