class Meal < ActiveRecord::Base
  
	has_many :meal_ingredients
	belongs_to :user
	has_many :ingredients, through: :meal_ingredients

	# validates_presence_of :date_time
end



