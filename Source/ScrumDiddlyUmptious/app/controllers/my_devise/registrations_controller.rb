#this class is about the current user, no admin functions should be in here
class MyDevise::RegistrationsController < Devise::RegistrationsController
  add_breadcrumb "Home", :recipes_path

  def create
    super
    @preference = Preference.new(:id_Users => current_user.id)
    @preference.save
  end

  def edit
    @user = current_user
    add_breadcrumb @user.username, user_path(@user)
    super
  end

  def destroy
    user = current_user
    super
    #this will have to be more and more edited as functions are inputted
    if resource.destroy
      @recipes = Recipe.where("id_Users = :resource_id", {resource_id: resource.id})
      if @recipes
        @recipes.each do |recipe|
          recipe.destroy
        end
      end
    
    preference = Preference.find_by_id_Users(user.id)
    preference.destroy

    end
  end

end
