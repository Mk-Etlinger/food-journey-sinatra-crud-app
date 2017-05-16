class MealsController < ApplicationController

  get '/new' do
    redirect("/login") if !logged_in?(session)
    @ingredients = Ingredient.all
    haml :'meals/new'
  end

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  post '/new' do
    binding.pry
    @meal = current_user.meals.build(params[:meal])

    new_ingredients = params[:ingredients][:name]
  
    if new_ingredients.include?(",") 
      @meal.parse_ingredients(new_ingredients)
    elsif !new_ingredients.include?(",") && !new_ingredients.empty?
      @meal.ingredients << Ingredient.find_or_create_by(name: new_ingredients)
    end
    @meal.save
    
    redirect "dashboard/#{@user.username}"
  end

  
  
  
  
  
  
  
  
  
  
  get '/edit/:id' do
    redirect("/login") if !logged_in?(session)
    @meal = Meal.find(params[:id])
    @ingredients = Ingredient.all
    haml :'meals/edit'
  end

  patch '/edit' do
    @meal = Meal.find_by(description: params[:meal][:description])

    @meal.update(params[:meal])
    
    new_ingredients = params[:ingredients][:name]
   
    if new_ingredients.include?(",")
      @meal.parse_ingredients(new_ingredients)
    elsif !new_ingredients.include?(",") && !new_ingredients.empty?
      @meal.ingredients << Ingredient.find_or_create_by(name: new_ingredients)
    end
    @meal.save

    redirect "dashboard/#{@meal.user.username}"
  end
  














  get '/delete/:id' do 
    redirect("/login") if !logged_in?(session)
    @meal = Meal.find(params[:id]).destroy
    redirect "dashboard/#{@meal.user.username}"
  end

  get '/meal/:id' do 
    redirect("/login") if !logged_in?(session)
    @meal = Meal.find(params[:id])
    haml :'meals/show'
  end
  
end

