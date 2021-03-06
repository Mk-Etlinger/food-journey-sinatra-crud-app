class Meal < ActiveRecord::Base
  has_many :meal_ingredients
  belongs_to :user
  has_many :ingredients, through: :meal_ingredients

  validates_presence_of :meal_type, :description
  validates :description, length: { maximum: 30 }

  def parse_ingredients(new_ingredients)
    new_ingredients.split(',').each do |ingredient|
      ingredients << Ingredient.find_or_create_by(name: ingredient.strip)
    end
  end

  #def ingredients_attributes=(ingredients)
    #ingredients = [{name: "sausage"}, {name: "eggs"}, {name: "cheese"}]
    #self.ingredients.find_or_create_by

  #end
  
end
