class MealIngredients < ActiveRecord::Base

  belongs_to :ingredients
  belongs_to :meals

end

