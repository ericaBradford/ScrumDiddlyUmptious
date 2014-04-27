class MyDevise::RegistrationsController < Devise::RegistrationsController

  def new
    super
  end  

  def create
    super
    redirect_to user_users_preferences_path(current_user.id)
  end

  def edit
    super
  end

  def update
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

end
