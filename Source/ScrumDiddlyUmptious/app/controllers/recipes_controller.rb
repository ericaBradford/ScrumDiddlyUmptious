class RecipesController < ApplicationController
  add_breadcrumb "Home", :recipes_path



  def index
    @meat = ["chicken", "pork", "beef", "steak", "meat", "jello", "marshmellows", "parmigiano-reggiano", "gummy"]
    @alcohol = ["alcohol", "amaretto", "beer", "bourbon", "champagne", "grand marnier", "rum", "tequila", "whisky", "wine", "vodka", "liquer"]
    @dairy = ["aart", "amasi", "Ayran", "baked milk", "basundi", "bhuna khoyo", "blaand", "black kashk", "booza", "buffalo curd", "bulgarian yogurt", "2% milk", "regular milk", "2 percent milk", "two percent milk", "whole milk", "1% milk", "land o lakes butter", "buttermilk", "yogurt", "cheese", "cream", "gelato", "ice cream", "whey", "2% milk", "regular milk", "2 percent milk", "two percent milk", "whole milk", "1% milk", "land o lakes butter", "country crock butter"]
    @egg = ["egg", "eggs", "omelete", "quiche"]
    @shellfish = ["lobster", "oyster", "shrimp", "clam", "crab", "sushi"]
    @fish = ["anchovies", "bass", "catfish", "cod", "flounder", "grouper", "haddock", "hake", "halibut", "herring", "mahi mahi", "perch", "pike", "pollock", "salmon", "scrod", "swordfish", "sole", "snapper", "tilapia", "trout", "tuna", "caesar salad", "caesar dressing", "worcestershire", "bouillapaisse", "fish", "imitation fish", "imitation shellfish", "imitation crab", "meatloaf", "barbecue sauce", "caponata"]
    @soy = ["soy", "edamame", "miso", "tempeh", "tofu"]
    @wheat = ["wheat", "flour", "bread", "pasta", "cake", "cookie", "noodle", "pizza", "cereal"]
    @gluten = ["white flour", "whole wheat flour", "durum wheat", "wheat", "graham flour", "triticale", "kamut", "semolina", "spelt", "wheat germ", "wheat bran", "pasta", "noodles", "flour tortillas", "cookie", "cake", "muffin", "pastry", "cereal", "crackers", "beer", "oats", "gravy", "dressing"]
    @treenut = ["nut", "almond", "cashew", "filbert", "pecan", "pistachio", "macadamia"]
    @peanut = ["peanuts", "granola", "chex mix", "blackberry punch", "cherry punch", "molasses", "candy bar", "buttermilk", "caramel", "cream cheese", "cheese nut sage", "cheese pimento", "cheese sandwich", "chili", "chop suey", "cocoa", "cooking oil", "curd", "instant coffee", "mayo", "meat substitute", "mock", "pancake flour", "pickle", "salad oil", "vinegar", "worcestershire"]
    @poultry = ["chicken", "duck", "geese", "turkey", "quail", @egg, "squab", "guinea fowl"]


    allRecipes = Recipe.order("title")
    @recipes = Array.new
    #check if user is signed in to see if there is any filtering needed
    if user_signed_in?
      preference = Preference.find_by_id_Users(current_user.id)
      @blacklistFoods = Array.new
       #populate blacklistFoods if there are foods in the foodsToFilter variable in preferences
        @blacklistFoods = preference.blacklistFoods.split(",").collect{|x| x.strip}
      
      #vegan, vegetarian, pescatarian
      if preference.isVegan? || preference.isVegetarian? || preference.isPescatarian?
        @blacklistFoods.concat(@meat)
        if !preference.isPescatarian?
          @blacklistFoods.concat(@fish)
          @blacklistFoods.concat(@shellfish)
        end
        if preference.isVegan?
          @blacklistFoods.push("honey")
          @blacklistFoods.concat(@dairy)
          @blacklistFoods.concat(@egg)
        end
      end
      if preference.isDiabetic?
        @blacklistFoods.push("sugar", "candy", "raisins", "syrup", "bacon", "soda", "white bread", "cake", "whole milk")
      end

      if preference.noAlcohol?
        @blacklistFoods.concat(@alcohol)
      end
      if preference.isAllergicGluten?
        @blacklistFoods.concat(@gluten)
      end
      if preference.isAllergicPeanuts?
        @blacklistFoods.concat(@peanut)
      end
      if preference.isAllergicTreenuts?
        @blacklistFoods.concat(@treenut)
      end
      if preference.isAllergicDairy?
        @blacklistFoods.concat(@dairy)
      end
      if preference.isAllergicEggs?
        @blacklistFoods.concat(@egg)
      end
      if preference.isAllergicWheat?
        @blacklistFoods.concat(@wheat)
      end
      if preference.isAllergicSoy?
        @blacklistFoods.concat(@soy)
      end
      if preference.isAllergicFish?
        @blacklistFoods.concat(@fish)
      end
      if preference.isAllergicShellfish?
        @blacklistFoods.concat(@shellfish)
      end


      if preference.isAsianVegetarian?
        @blacklistFoods.push("onion", "garlic")
        @blacklistFoods.concat(@meat)        
        @blacklistFoods.concat(@shellfish)
        @blacklistFoods.concat(@egg)
        @blacklistFoods.concat(@poultry)
        @blacklistFoods.concat(@fish)
      end
      if preference.isHindu?
        @blacklistFoods.push("beef", "garlic", "mushroom", "tea", "coffee")
        @blacklistFoods.concat(@alcohol)
      end
      if preference.isMuslim?
        @blacklistFoods.concat(@meat)
        @blacklistFoods.concat(@alcohol)
        @blacklistFoods.concat(@dairy)
        blacklistFoods.concat(@egg)
      end
      if preference.isJain?
        @blacklistFoods.push("onion", "garlic")
        @blacklistFoods.concat(@meat)
      end
      if preference.isKosher?
        @blacklistFoods.push("bacon", "pork", "gelatin", "beer", "wine", "ham", "camel", "turkey", "insect", "rat", "rodent", "reptile", "snake", "frog")
        @blacklistFoods.concat(@egg)
        blacklistFoods.concat(@shellfish)
      end

      recipeArray = Array.new
      #actual filter time!
      if @blacklistFoods.empty?
        @recipes = allRecipes.page(params[:page]).per(5)
      else
        dontInclude = false
        allRecipes.each do |recipe|
          @blacklistFoods.each do |food|
            if recipe.ingredients.downcase.include? food
              dontInclude = true
            end
          end
          #just finished checking all the foods for 1 recipe. Time to see if this recipe can be added
          if !dontInclude
            recipeArray.push(recipe)
          end
          dontInclude=false
        end
        @recipes = Kaminari.paginate_array(recipeArray).page(params[:page]).per(5)
      end
    #result if user isn't signed in
    else
      @recipes = allRecipes.page(params[:page]).per(5)
    end
  end

  def new
    @recipe = Recipe.new
    authorize! :create, @recipe
    add_breadcrumb "New", :new_recipe_path
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
    @favorite = FavoriteRecipe.where("id_Recipes = ? AND id_Users = ?", @recipe.id, current_user.id).first
    if @favorite.blank?
      @isFav = "false"
    else
      @isFav = "true"
    end
    add_breadcrumb @recipe.title, recipe_path(@recipe)
  end

  def edit
    @recipe = Recipe.find(params[:id])
    authorize! :update, @recipe
    add_breadcrumb @recipe.title, recipe_path(@recipe)
    add_breadcrumb "Edit", edit_recipe_path(@recipe)    
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

  def favorite
    type = params[:type]
    @recipe = Recipe.find(params[:id])
    @user = User.find(current_user.id)
    if type == "favorite"
      @favorite = FavoriteRecipe.new(:id_Recipes => @recipe.id, :id_Users => current_user.id)
      @favorite.save
      redirect_to :back, notice: "#{@recipe.title} added to favorites"
    elsif type == "unfavorite"
      @unfavorite = FavoriteRecipe.where("id_Recipes = ? AND id_Users = ?", params[:id], current_user.id).first
      FavoriteRecipe.delete(@unfavorite.id)
      redirect_to :back, notice: "#{@recipe.title} removed from favorites"
    end
  end

  private

    def recipe_params
      params.require(:recipe).permit(:title, :directions, :description, :cookTime, :costOfIngredients, :canPrepareAhead, :id_Users, :ingredients, :picture)
    end
end
