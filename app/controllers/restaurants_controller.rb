class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [:show, :edit, :update, :destroy]
  def index
    @restaurants = Restaurant.all
  end

  def show
    @dishes = Dish.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    if @restaurant.save!
      respond_to do |format|
        format.html {redirect_to restaurant_path(@restaurant)}
        format.turbo_stream
      end
    else
      render new:, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @restaurant.update!(restaurant_params)
    redirect_to root_path
  end

  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html {redirect_to restaurants_path, status: :see_other}
      format.turbo_stream
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
