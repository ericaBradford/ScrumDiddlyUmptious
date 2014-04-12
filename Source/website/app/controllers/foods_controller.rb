class FoodsController < ApplicationController
  def show
    @foods = Food.find(params[id])
  end

  def new
  end

  def create
    @food = Food.new(params[:food])
    if @food.save
      redirect_to :action => 'show', :id => @food
    else
      render :action => 'new'
    end
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    if @food.update_attributes(params[:food])
      redirect_to :action => 'show', :id=> @food
    else
      render :action => 'edit'
    end
  end

  def delete
    Food.find(params[:id]).destroy
    redirect_to home_url
  end
end

#@food = Food.new
