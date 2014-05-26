class RecipesController < ApplicationController
  add_breadcrumb "Home", :recipes_path

  def index
    search
    #if the user is searching based off of a specific column or something that can't use full text search, this will be called
    if @moreSearchNeeded
      advancedSearch
    end
    @recipesHolder = Array.new
    #check if user is signed in to see if there is any filtering needed
    if user_signed_in?
      check_preferences
    else
      @recipesHolder = @allRecipes
      paginate_time
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
    if user_signed_in?
      @favorite = FavoriteRecipe.where("id_Recipes = ? AND id_Users = ?", @recipe.id, current_user.id).first
      if @favorite.blank?
        @isFav = "false"
      else
        @isFav = "true"
      end
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

    if @recipe.update(recipe_edit_params)
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
    @recipe = Recipe.find(params[:recipe_id])
    @user = User.find(current_user.id)
    if type == "favorite"
      @favorite = FavoriteRecipe.new(:id_Recipes => @recipe.id, :id_Users => current_user.id)
      @favorite.save
      redirect_to :back, notice: "#{@recipe.title} added to favorites"
    elsif type == "unfavorite"
      @unfavorite = FavoriteRecipe.where("id_Recipes = ? AND id_Users = ?", @recipe.id, current_user.id).first
      FavoriteRecipe.delete(@unfavorite.id)
      redirect_to :back, notice: "#{@recipe.title} removed from favorites"
    end
  end

  #displays the advanced search form page
  def displayAdvancedSearchPage
    render 'advancedSearch'
  end

  #this is the action that the form is sent to. This gets the variables and gets easy to search variables ready for the search method
  def prepareSearch
   if params[:blacklist] != ""
     @blacklistSearch = params[:blacklist].to_s.split(",").collect{|x| x.strip}
   end

   redirect_to root_path(:blacklistSearch => @blacklistSearch, 
   :classification => params[:classification], :cookware => params[:cookware], :category => params[:category], :ingredients => params[:ingredients], :costOfIngredients => params[:costOfIngredients], :num => params[:numIngredients], :time => params[:cookTime], :rating => params[:rating], :prepareAhead => params[:prepareAhead], :cost => params[:costIngredients])
  end



  private
    #this is the search method that Sunspot uses to do its full text searches
    def search
      search = Recipe.search do
        fulltext params[:search]
        fulltext params[:classification]
        fulltext params[:cookware]
        
        fulltext params[:category] do
          fields(:category)
        end
        fulltext params[:ingredients] do
          fields(:ingredients)
        end
        #order_by :rating, :desc
      end
      @allRecipes = search.results
      if params[:costOfIngredients] || params[:numIngredients] || params[:cookTime] || params[:rating] || params[:prepareAhead] || params[:costIngredients]
        @moreSearchNeeded = true
      end
    end



    #the reason this method exists is because the other searches need to be done before this one goes. That's because of how @allRecipes is assigned first in the search action. So this is for after that to perform searches on what remains
    def advancedSearch
      #double check that @allRecipes needs to be changed for advanced search
      if params[:costOfIngredients] || params[:numIngredients] || params[:cookTime] || params[:rating] || params[:prepareAhead] || params[:costIngredients]
        searchResults = Array.new

        @allRecipes.each do |recipe|
          if params[:numIngredients] != ""
            
          end
          if params[:cookTime] != ""
            
          end
          if params[:rating] != ""
            @rating = recipe.average_rating
            if @rating >= params[:rating].to_f
              searchResults.push(recipe)
            end
          end
          if !params[:prepareAhead].blank?
            @prepare = params[:prepareAhead]
            if recipe.canPrepareAhead == "1"
              searchResults.push(recipe)
            end
          end
          if params[:cost] != ""
              if recipe.costOfIngredients <= params[:cost].to_f
                searchResults.push(recipe)
              end
          end
        end
      end
      if !searchResults.empty?
        @allRecipes.clear
        @allRecipes = searchResults
      end
      @moreSearchNeeded = false
    end

    def check_preferences
      preference = Preference.find_by_id_Users(current_user.id)
      @blacklistFoods = Array.new
       #populate blacklistFoods if there are foods in the foodsToFilter variable in preferences
      @blacklistFoods = preference.blacklistFoods.split(",").collect{|x| x.strip}

      if params.has_key?('blacklistSearch')
        @blacklistFoods.concat(params[:blacklistSearch])
      end
      
      #vegan, vegetarian, pescatarian
      if preference.isVegan? || preference.isVegetarian? || preference.isPescatarian?
        @blacklistFoods.concat(Recipe.meat)
        if !preference.isPescatarian?
          @blacklistFoods.concat(Recipe.fish)
          @blacklistFoods.concat(Recipe.shellfish)
        end
        if preference.isVegan?
          @blacklistFoods.push("honey")
          @blacklistFoods.concat(Recipe.dairy)
          @blacklistFoods.concat(Recipe.egg)
        end
      end
      if preference.isDiabetic?
        @blacklistFoods.push("sugar", "candy", "raisins", "syrup", "bacon", "soda", "white bread", "cake", "whole milk", "ice cream")
      end

      if preference.noAlcohol?
        @blacklistFoods.concat(Recipe.alcohol)
      end
      if preference.isAllergicGluten?
        @blacklistFoods.concat(Recipe.gluten)
      end
      if preference.isAllergicPeanuts?
        @blacklistFoods.concat(Recipe.peanut)
      end
      if preference.isAllergicTreenuts?
        @blacklistFoods.concat(Recipe.treenut)
      end
      if preference.isAllergicDairy?
        @blacklistFoods.concat(Recipe.dairy)
      end
      if preference.isAllergicEggs?
        @blacklistFoods.concat(Recipe.egg)
      end
      if preference.isAllergicWheat?
        @blacklistFoods.concat(Recipe.wheat)
      end
      if preference.isAllergicSoy?
        @blacklistFoods.concat(Recipe.soy)
      end
      if preference.isAllergicFish?
        @blacklistFoods.concat(Recipe.fish)
      end
      if preference.isAllergicShellfish?
        @blacklistFoods.concat(Recipe.shellfish)
      end


      if preference.isAsianVegetarian?
        @blacklistFoods.push("onion", "garlic")
        @blacklistFoods.concat(Recipe.meat)        
        @blacklistFoods.concat(Recipe.shellfish)
        @blacklistFoods.concat(Recipe.egg)
        @blacklistFoods.concat(Recipe.poultry)
        @blacklistFoods.concat(Recipe.fish)
      end
      if preference.isHindu?
        @blacklistFoods.push("beef", "garlic", "mushroom", "tea", "coffee")
        @blacklistFoods.concat(Recipe.alcohol)
      end
      if preference.isMuslim?
        @blacklistFoods.concat(Recipe.meat)
        @blacklistFoods.concat(Recipe.alcohol)
        @blacklistFoods.concat(Recipe.dairy)
        @blacklistFoods.concat(Recipe.egg)
      end
      if preference.isJain?
        @blacklistFoods.push("onion", "garlic")
        @blacklistFoods.concat(Recipe.meat)
      end
      if preference.isKosher?
        @blacklistFoods.push("bacon", "pork", "gelatin", "beer", "wine", "ham", "camel", "turkey", "insect", "rat", "rodent", "reptile", "snake", "frog")
        @blacklistFoods.concat(Recipe.egg)
        @blacklistFoods.concat(Recipe.shellfish)
      end
      filter
    end



    def filter
      recipeArray = Array.new
      if @blacklistFoods.empty?
        @recipesHolder = @allRecipes
      else
        dontInclude = false
        @allRecipes.each do |recipe|
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
        @recipesHolder = recipeArray
      end
      paginate_time
    end




    def paginate_time
      @recipes = @recipesHolder.paginate(:page => params[:page], :per_page => 5)
      render "index"
    end


    def recipe_params
      params.require(:recipe).permit(:title, :directions, :description, :cookTime, :costOfIngredients, :category, :canPrepareAhead, :id_Users, :ingredients, :picture)
    end

    def recipe_edit_params
params.require(:recipe).permit(:title, :directions, :description, :cookTime, :costOfIngredients, :canPrepareAhead, :ingredients, :picture, :category)
    end

    def search_params
      params.permit(:ingredients, :costIngredients, :numIngredients, :cookTime, :rating, :classification, :cookware, :category, :prepareAhead, :blacklist)
    end
end
