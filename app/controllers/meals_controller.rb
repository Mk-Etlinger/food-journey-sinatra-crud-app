class MealsController < ApplicationController

  get '/new' do

    haml :'meals/new'
  end

  post '/new' do
    @meal = Meal.create(params[:meal])
    @user = User.find(session[:id])
    @meal.user_id = @user.id
    new_ingredients = params[:ingredients][:name]
    existing_ingredients = params[:ingredients][:ids]
   
    if new_ingredients.include?(",") && !existing_ingredients.nil?
      new_ingredients.split(", ").each do |ing|
        @meal.ingredients << Ingredient.create(name: ing) && Ingredient.find(existing_ingredients)
      end
    elsif new_ingredients.empty? && !existing_ingredients.nil?
      @meal.ingredients << Ingredient.find(existing_ingredients)
    elsif !new_ingredients.include?(",") && !existing_ingredients.nil?
      @meal.ingredients << Ingredient.create(name: new_ingredients)
      @meal.ingredients << Ingredient.find(existing_ingredients)
    else
      new_ingredients.split(", ").each { |ing| @meal.ingredients << Ingredient.create(name: ing) } if new_ingredients.include?(",")
      
      @meal.ingredients << Ingredient.create(name: new_ingredients) if !new_ingredients.include?(",")
    end
    
    redirect "dashboard/#{@user.username}"
  end

  get '/edit/:id' do
    @meal = Meal.find(params[:id])
    
    haml :'meals/edit'
  end

  patch '/edit' do
    binding.pry
    redirect "dashboard/#{@user.username}"
  end
  

end
