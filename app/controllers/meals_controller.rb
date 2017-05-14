class MealsController < ApplicationController

  get '/new' do

    haml :'meals/new'
  end

  post '/new' do
    binding.pry
    @meal = Meal.create(params[:meal])
    @user = User.find(session[:id])
    @ingredients = Ingredient.create()
    @meal.user_id = @user.id

  end

end
