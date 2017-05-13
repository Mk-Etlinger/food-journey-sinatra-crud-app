class Meal < ActiveRecord::Base
    
	belongs_to :user
	has_many :ingredients, through: :meal_ingredients

	validates_presence_of :date
end



