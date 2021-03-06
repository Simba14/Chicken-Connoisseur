class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    # @restaurant.reviews.create(review_params, user_id: current_user.id)
    @review = @restaurant.build_review review_params, current_user

    if @review.save
      redirect_to '/restaurants'
    else
      if @review.errors[:user]
        redirect_to restaurants_path, notice: 'You have already reviewed this restaurant'
      else
        render :new
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end



end
