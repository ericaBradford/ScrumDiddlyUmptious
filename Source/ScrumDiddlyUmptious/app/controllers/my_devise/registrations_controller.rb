class MyDevise::RegistrationsController < Devise::RegistrationsController

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

end
