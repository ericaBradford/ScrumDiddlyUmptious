class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :recipes_ingredients]

  def recipes_ingredient
    @foods = Food.all
  end

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    
    if @recipe.save
      redirect_to @recipe
    else
      render 'new'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path
  end

 private
  def recipe_params
    params.require(:recipe).permit(:title, :directions, :cookTime, :costOfIngredients, :canPrepareAhead, 
  :foods_attributes => [:id, :foodName,
  :recipes_ingredient_attributes => [:id, :user_id]
   ])
  end
end

#deal with getting ingredients into here later
#do notifications n stuff
