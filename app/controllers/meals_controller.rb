require 'pry'

class MealsController < ApplicationController
  ['/meals/new', '/meals/*'].each do |path|
    before path do
      authenticate_user
    end
  end

  get '/meals/new' do
    set_ingredients

    haml :'meals/new'
  end

  post '/meals/new' do
    @meal = current_user.meals.build(params[:meal])
    @new_ingredients = params[:ingredients][:name]

    build_ingredient_associations

    if @meal.save
      redirect_to_dashboard
    else
      flash[:error] = @meal.errors.full_messages
      redirect('/meals/new')
    end
  end

  get '/meals/:id/edit' do
    set_meal
    set_ingredients

    if current_user == @meal.user
      haml :'meals/edit'
    else
      redirect_to_dashboard
    end
  end

  patch '/meals/:id' do
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

  get '/meals/:id/delete' do
    set_meal
    @meal.destroy
    redirect_to_dashboard
  end

  get '/meals/:id' do
    set_meal

    haml :'meals/show'
  end

  helpers do
    def set_meal
      @meal = Meal.find_by(id: params[:id])
    end

    def set_ingredients
      @ingredients = Ingredient.all.sort_by(&:name)
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
