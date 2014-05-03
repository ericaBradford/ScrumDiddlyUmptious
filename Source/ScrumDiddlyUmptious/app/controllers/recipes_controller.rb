class RecipesController < ApplicationController
#what if they check multiple food preferences? Check against multiple scopes???
  #also remember to do if statements to make sure that the user has clicked "yes I'm vegan" in preferences
#has_scope :by_manufacturer, if: vehicle_manufacturer_id.present?
#if, find user preferences by looking for current_user.id in preferences table. If true, add scope
  #has_scope :vegan
  has_scope :by_title

  def index
    @meat = ["chicken", "pork", "beef", "steak", "meat", "jello", "marshmellows", "parmigiano-reggiano", "gummy"]
    @alcohol = ["alcohol", "amaretto", "beer", "bourbon", "champagne", "grand marnier", "rum", "tequila", "whisky", "wine", "vodka", "liquer"]
    @dairy = ["aart", "amasi", "Ayran", "baked milk", "basundi", "bhuna khoyo", "blaand", "black kashk", "booza", "buffalo curd", "bulgarian yogurt", "2% milk", "regular milk", "2 percent milk", "two percent milk", "whole milk", "1% milk", "land o lakes butter", "buttermilk", "yogurt", "cheese", "cream", "gelato", "ice cream", "whey", "2% milk", "regular milk", "2 percent milk", "two percent milk", "whole milk", "1% milk", "land o lakes butter", "country crock butter",]
    @egg = ["egg", "eggs"]

    allRecipes = apply_scopes(Recipe).all.order("title").page(params[:page]).per(10)
    @recipes = Array.new
    #check if user is signed in to see if there is any filtering needed
    if user_signed_in?
      preference = Preference.find_by_id_Users(current_user.id)
      @foodsToFilter = []
       #populate foodsToFilter if there are foods in the foodsToFilter variable
      if !preference.foodsToFilter.empty?
        @foodsToFilter = preference.foodsToFilter.split(",").collect{|x| x.strip}
      end
      if preference.isVegan?
        @foodsToFilter.push(@meat, @dairy, "eggs", "egg", "fish", "honey")
      end
      if preference.isVegetarian?
        @foodsToFilter.push(@meat, "fish")
      end
      if preference.isPescatarian?
        @foodsToFilter.push(@meat)
      end
      if preference.isDiabetic?
        @foodsToFilter.push("sugar", "candy", "raisins", "syrup", "bacon", "soda", "white bread", "cake", "whole milk")
      end
      if preference.noAlcohol?
        @foodsToFilter.push(@alcohol)
      end
      if preference.isAllergicGluten?
        @foodsToFilter.push("white flour", "whole wheat flour", "durum wheat", "wheat", "graham flour", "triticale", "kamut", "semolina", "spelt", "wheat germ", "wheat bran", "pasta", "noodles", "flour tortillas", "cookie", "cake", "muffin", "pastry", "cereal", "crackers", "beer", "oats", "gravy", "dressing")
      end
      if preference.isAllergicPeanuts?
        @foodsToFilter.push("peanuts", "granola", "chex mix")
      end
      if preference.isAllergicTreenuts?
        @foodsToFilter.push("nut", "almond", "cashew", "filbert", "pecan", "pistachio")
      end
      if preference.isAllergicDairy?
        @foodsToFilter.push(@dairy)
      end
      if preference.isAllergicEggs?
        @foodsToFilter.push("egg", "eggs")
      end
      if preference.isAllergicWheat?
        @foodsToFilter.push("wheat", "flour", "bread", "pasta", "cake", "cookie", "noodle", "pizza", "cereal")
      if preference.isAllergicSoy?
        @foodsToFilter.push("soy", "edamame", "miso", "tempeh", "tofu")
      end
      if preference.isAllergicFish?
        @foodsToFilter.push("fish", "salmon")
      end
      if preference.isAllergicShellfish?
        @foodsToFilter.push("shellfish")
      end
      if preference.isAsianVegetarian?
        @foodsToFilter.push(@meat, "fish", "parmigiano-reggiano", "onion", "garlic")
      end
      if preference.isHindu?
        @foodsToFilter.push("beef", "garlic", "mushroom", "tea", "coffee", @alcohol)
      end
      if preference.isMuslim?
        @foodsToFilter.push(@meat, @alcohol, @dairy, @egg)
      end
      if preference.isJain?
        @foodsToFilter.push(@meat, "onion", "garlic")
      end
      if preference.isKosher?
        @foodsToFilter.push()
      end


 #!!!!check for all other preferences here. If yes, add to foodsToFilter. 
      @recipeArray = Array.new
      #actual filter time!
      if @foodsToFilter.empty?
        @recipes = allRecipes
      else
        dontInclude = false
        allRecipes.each do |recipe|
          @foodsToFilter.each do |food|
            if recipe.ingredients.downcase.include? food
              dontInclude = true
            end
          end
          #just finished checking all the foods for 1 recipe. Time to see if this recipe can be added
          if !dontInclude
            @recipeArray.push(recipe)
          end
          dontInclude=false
        end
        @recipes = Kaminari.paginate_array(@recipeArray).page(params[:page]).per(10)
      end
    #result if user isn't signed in
    else
      @recipes = allRecipes
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
