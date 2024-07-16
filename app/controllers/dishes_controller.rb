class DishesController < ApplicationController
  before_action :set_dish, only: %i[ show dishes edit destroy]
  before_action :set_restaurant, only: %i[ edit show new create]

  def index
    @dishes = Dish.all
  end

  def show;end

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.new(params_dish)
    @dish.restaurant = @restaurant
    if @dish.save!
      redirect_to restaurant_dish_path(@restaurant, @dish)
    else
      render new:, status: :unprocessable_entity
    end

  end

  def edit;end

  def update
    raise
    @dish.update!(params_dish)
    redirect_to restaurant_dish_path(@dish)
  end

  def destroy
    @dish.destroy
    redirect_to restaurant_path(@dish.restaurant), status: :see_other
  end

  private

  def set_dish
    @dish = Dish.find(params[:id])
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def params_dish
    params.require(:dish).permit(:name, :price, :description, :status)
  end
end
