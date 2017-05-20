class CreateMealIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :meal_ingredients do |table|
      table.integer :meal_id
      table.integer :ingredient_id  
    end
  end
end
