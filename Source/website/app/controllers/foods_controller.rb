class FoodsController < ApplicationController

  before_filter :authenticate_user!, :exept => [:show, :index]

  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      redirect_to @food, notice: "Food successfully saved!"
    else
      render 'new'
    end
  end

  def show
    @food = Food.find(params[:id])
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])

    if @food.update(food_params)
      redirect_to @food, notice: "Food successfully edited!"
    else
      render 'edit'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path, notice: "Food successfully deleted!"
  end

 private
  def food_params
    params.require(:food).permit(:foodName, :description, :isDairyFree, 
:isEggFree, :isShellfishFree, :isFishFree, :isMeatFree, :isGlutenFree, 
:isWheatFree, :isHighFiber, :isSugarFree, :isPeanutFree, :isTreeNutFree, 
:isSoyFree, :id_Users)
  end
end
