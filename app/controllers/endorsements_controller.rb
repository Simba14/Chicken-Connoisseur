class EndorsementsController < ApplicationController

  def new
    create
  end

  def create
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    redirect_to "/restaurants/#{@review.restaurant_id}"
  end

end
