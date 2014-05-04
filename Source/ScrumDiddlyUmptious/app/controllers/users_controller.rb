class UsersController < ApplicationController
  add_breadcrumb :index, :users_path

  def index
    @users = User.all

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
  end

  def editRole
    @admin = current_user.id
  end

  def promote
    @user = User.find(params[userId])
    @admin = current_user.id
  end
end
