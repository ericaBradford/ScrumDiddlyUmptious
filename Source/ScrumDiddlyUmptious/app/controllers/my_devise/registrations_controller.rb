class MyDevise::RegistrationsController < Devise::RegistrationsController
  before_action :addVeganToFilters, only: :update

  def new
    super
  end  

  def create
    super
  end

  def edit
    super
  end

  def update
    if params[:isVegan] == '1'
      params[:foodsToFilter] ||= "beef, chicken, ham, fish, steak, milk, butter, cheese, eggs, jello, marshmallows, marshmellows, marshmallow, marshmello, honey, whey, salmon, #{params[:foodToFilter]}"
    end
    params[:foodsToFilter] = "here"
    params.delete :isVegan
    super
  end

  def destroy
    super
    #this will have to be more and more edited as functions are inputted
    if resource.destroy
      @recipes = Recipe.where("id_Users = :resource_id", {resource_id: resource.id})
      if @recipes
        @recipes.each do |recipe|
          recipe.destroy
        end
      end
    end
  end

  def cancel
    super
  end

 private

  def addVeganToFilters
    user.foodsToFilter = "yes"
    params.delete :isVegan
  end

end
