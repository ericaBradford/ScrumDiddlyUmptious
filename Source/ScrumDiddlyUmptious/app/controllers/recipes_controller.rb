class RecipesController < ApplicationController
#what if they check multiple food preferences? Check against multiple scopes???
  #also remember to do if statements to make sure that the user has clicked "yes I'm vegan" in preferences
#has_scope :by_manufacturer, if: vehicle_manufacturer_id.present?
#if, find user preferences by looking for current_user.id in preferences table. If true, add scope
  #has_scope :vegan
  has_scope :canPrepareAhead, :type => :boolean

  def index
    if user_signed_in?
      @recipes = apply_scopes(Recipe).order("title").page(params[:page]).per(10)
    else
      @recipes = apply_scopes(Recipe).order("title").page(params[:page]).per(10)
    end
  end

  def new
    @recipe = Recipe.new
    authorize! :create, @recipe
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
    authorize! :update, @recipe
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
    authorize! :destroy, @recipe
    redirect_to recipes_path, notice: "Recipe successfully deleted!"
  end

  private
    def recipe_params
      params.require(:recipe).permit(:title, :directions, :cookTime, :costOfIngredients, :canPrepareAhead, :id_Users, :ingredients)
    end
end
