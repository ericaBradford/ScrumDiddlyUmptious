#this class is about the current user, no admin functions should be in here
class MyDevise::RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        @preference = Preference.new(:id_Users => current_user.id)
        @preference.save
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def edit
    @user = current_user
    add_breadcrumb "Home", :recipes_path
    add_breadcrumb @user.username, user_path(@user)
    render 'edit'
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end



  def destroy

    user = User.find(params[:id])
    #this will have to be more and more edited as functions are inputted
    if resource.destroy
      @recipes = Recipe.where("id_Users = :resource_id", {resource_id: resource.id})
      favorites = Array.new
      if @recipes
        @recipes.each do |recipe|
          favoriteRecipe = FavoriteRecipe.find_by_id_Recipes(recipe.id)
          favorites.push(favoriteRecipe)
          recipe.destroy
        end
      end
      if favorites
        favorites.each do |fav|
          fav.destroy
        end
      end
    preference = Preference.find_by_id_Users(user.id)
    preference.destroy

    end


    super
  end


 private

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up) {|u| u.permit(:avatar)}
  end

end
