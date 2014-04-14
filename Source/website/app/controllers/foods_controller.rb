class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @message = "Your food item has been created!"

    if @food.save
      redirect_to @food
    else
      render 'new'
    end
  end


  def show
    @food = Food.find(params[:id])
  end

  def edit
    @food = Food.find(params[:id])
    @message = "Your food item has been edited!"
  end

  def update
    @food = Food.find(params[:id])
    @message = "Your food item has been edited!"

    if @food.update(food_params)
      redirect_to @food
    else
      render 'edit'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @message = "Your food item has been deleted"
    @food.destroy

    redirect_to foods_path
  end

 private
  def food_params
    params.require(:food).permit(:foodName, :description, :isDairyFree, 
:isEggFree, :isShellfishFree, :isFishFree, :isMeatFree, :isGlutenFree, 
:isWheatFree, :isHighFiber, :isSugarFree, :isPeanutFree, :isTreeNutFree, 
:isSoyFree)
  end
end
