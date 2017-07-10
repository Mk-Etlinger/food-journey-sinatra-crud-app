require 'pry'

class MealsController < ApplicationController
  ['/meals/new', '/meal/edit/*', '/meal/*', '/meal/delete/*'].each do |path|
    before path do
      authenticate_user
    end
  end

  get '/meals/new' do
    @ingredients = Ingredient.all.sort_by(&:name)

    haml :'meals/new'
  end

  post '/meals/new' do
    @meal = current_user.meals.build(params[:meal])

    @new_ingredients = params[:ingredients][:name]

    build_ingredient_associations
    @meal.save
    flash[:error] = @meal.errors.full_messages

    if @meal.errors.any?
      redirect('/meals/new')
    else
      redirect_to_dashboard
    end
  end

  get '/meal/edit/:id' do
    @meal = Meal.find(params[:id])
    @ingredients = Ingredient.all.sort_by(&:name)

    if current_user == @meal.user
      haml :'meals/edit'
    else
      redirect_to_dashboard
    end
  end

  patch '/meals/edit/:id' do
    set_meal

    if @meal.update(params[:meal])
      @new_ingredients = params[:ingredients][:name]
      build_ingredient_associations
    else
      flash[:error] = @meal.errors.full_messages
      redirect back
    end

    @meal.save
    redirect_to_dashboard
  end

  get '/meal/delete/:id' do
    @meal = Meal.find(params[:id]).destroy
    redirect "dashboard/#{@meal.user.username}"
  end

  get '/meal/:id' do
    @meal = Meal.find(params[:id])

    haml :'meals/show'
  end

  helpers do
    def set_meal
      @meal = Meal.find_by(id: params[:id])
    end

    def build_ingredient_associations
      if @new_ingredients.include?(',')
        @meal.parse_ingredients(@new_ingredients)
      elsif !@new_ingredients.include?(',') && !@new_ingredients.empty?
        @meal.ingredients << Ingredient.find_or_create_by(name: @new_ingredients)
      end
    end

    def flash_errors
      flash[:error] = @meal.errors.full_messages
    end
    
  end
end
