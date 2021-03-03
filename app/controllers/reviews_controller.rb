# Reviews controller
class ReviewsController < ApplicationController
  before_action :find_restaurant, only: %i[new create]

  def new
    # we need @restaurant in our `simple_form_for`
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    # we need `restaurant_id` to associate review with corresponding restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review.restaurant = @restaurant
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end
end

private

def find_restaurant
  @restaurant = Restaurant.find(params[:restaurant_id])
end

def review_params
  params.require(:review).permit(:content, :rating)
end
