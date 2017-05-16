class Ingredient < ActiveRecord::Base

  has_many :meal_ingredients
  has_many :meals, through: :meal_ingredients

  validates_presence_of :name

  def self.parse_ingredients(new_ingredients)
    binding.pry
    new_ingredients.split(",").each do |ingredient|
      @meal.ingredients << self.find_or_create_by(name: ingredient.strip)
    end
  end
end
