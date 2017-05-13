class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |table|
      table.datetime :date_time
      table.string :type
      table.integer :user_id
    end
  end
end
