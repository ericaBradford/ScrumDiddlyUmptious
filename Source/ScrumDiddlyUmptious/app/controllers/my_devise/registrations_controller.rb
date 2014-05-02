class MyDevise::RegistrationsController < Devise::RegistrationsController

  def create
    super
    @preference = Preference.new(:id_Users => current_user.id)
    @preference.save
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

end
