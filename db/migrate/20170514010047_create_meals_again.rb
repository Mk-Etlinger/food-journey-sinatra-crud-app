class CreateMealsAgain < ActiveRecord::Migration
  def change
    create_table :meals do |table|
      table.datetime :date_time
      table.string :meal_type
      table.integer :user_id
      table.string :description
    end
  end
end
