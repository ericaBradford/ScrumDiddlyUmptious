class RecipesController < ApplicationController
#  before_action :recipes_ingredients, only: [:show, :edit, :update, :destroy]

  def recipes_ingredient
    @foods = @recipes.foods
  end

  def index
    if session[:user_id]
      @recipes = Recipe.all
    else
      @recipes = nil
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    
      if @recipe.save
        redirect_to @recipe, notice: "Recipe successfully saved"
      else
        render 'new'
      end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @foods = Recipes_Ingredient.find_by recipe_id: :id
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe successfully updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path, notice: "Recipe successfully deleted!"
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
