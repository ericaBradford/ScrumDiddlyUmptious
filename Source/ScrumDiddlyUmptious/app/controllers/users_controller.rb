class UsersController < ApplicationController
  add_breadcrumb "Home", :recipes_path

  def index
    @users = User.all

    authorize! :index, @users

    respond_to do |format|
      format.html
      format.json {render json: @users}
      format.xml {render :xml => @users}
    end
  end

  def show
    @user = User.find(params[:id])
    @recipes = Recipe.where(id_Users: @user.id)

    respond_to do |format|
      format.html
      format.xml {render :xml => @user}
    end
    add_breadcrumb @user.username, user_path(@user)
    add_breadcrumb :index, :users_path
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
end
