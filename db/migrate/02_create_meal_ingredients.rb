class CreateMealIngredients < ActiveRecord::Migration
  def change
    create_table :meal_ingredients do |table|
      table.integer :meal_id
      table.integer :ingredient_id  
    end
  end
end
