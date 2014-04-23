class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "Recipe successfully created!"
    else
      render 'new'
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @chef = User.find(@recipe.id_Users)
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe successfully updated."
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
      params.require(:recipe).permit(:title, :directions, :cookTime, :costOfIngredients, :canPrepareAhead, :id_Users, :ingredients)
    end
end
