#this is kind of like the global user controller. Admin functions should go here.
class UsersController < ApplicationController
  add_breadcrumb "Home", :recipes_path
  add_breadcrumb "Users", :users_path

  def index
    @users = User.all
    authorize! :index, @users

    respond_to do |format|
      format.html
      format.json {render json: @users}
      format.xml {render :xml => @users}
    end
  end

  def edit
    @user = User.find(params[:id])
    !authorize! :update, @user
    add_breadcrumb @user.username, user_path(@user)
    add_breadcrumb "Edit", edit_user_path(@user)
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      redirect_to @user, notice: "User successfully updated."
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @recipes = Recipe.where(id_Users: @user.id)
    add_breadcrumb @user.username, user_path(@user)

    respond_to do |format|
      format.html
      format.xml {render :xml => @user}
    end
  end

  def editRole
    @admin = current_user
      if @admin.role == "admin"
      end
  end

  def promote
    @user = User.find_by_email(:email)
    @admin = current_user.id
  end

  def showFavs
    @user = current_user
    @recipeFavorites = FavoriteRecipe.where("id_Users = ?", @user.id)
    @recipes = Array.new
    @recipeFavorites.each do |rf|
      recipe = Recipe.find(rf.id_Recipes)
      @recipes.push(recipe)
    end
  end


 private

  def user_params
    params.require(:user).permit(:username, :email, :role)
  end
end
