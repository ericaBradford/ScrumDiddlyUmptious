class UsersController < ApplicationController
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
  end
end