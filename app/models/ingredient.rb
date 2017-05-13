class Ingredient < ActiveRecord::Base

  has_many :meals, through: :meal_ingredients

  validates_presence_of :description
end
