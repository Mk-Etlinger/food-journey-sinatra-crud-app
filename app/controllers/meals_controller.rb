class MealsController < ApplicationController

  get '/new' do
    authenticate_user
    @ingredients = Ingredient.all.sort_by { |ingredient| ingredient.name }
    
    haml :'meals/new'
  end
  
  post '/new' do
    @meal = current_user.meals.build(params[:meal])

    new_ingredients = params[:ingredients][:name]
  
    if new_ingredients.include?(",") 
      @meal.parse_ingredients(new_ingredients)
    elsif !new_ingredients.include?(",") && !new_ingredients.empty?
      @meal.ingredients << Ingredient.find_or_create_by(name: new_ingredients)
    end
    @meal.save
    
    redirect_to_dashboard
  end

  get '/edit/:id' do
    authenticate_user
    @meal = Meal.find(params[:id])
    @ingredients = Ingredient.all.sort_by { |ingredient| ingredient.name }
    
    if current_user == @meal.user
      haml :'meals/edit'
    else
      redirect_to_dashboard
    end 
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
    authenticate_user
    @meal = Meal.find(params[:id]).destroy
    redirect "dashboard/#{@meal.user.username}"
  end

  get '/meal/:id' do 
    authenticate_user
    @meal = Meal.find(params[:id])
    haml :'meals/show'
  end
  
end

