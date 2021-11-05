class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[index]

  def index
    @reviews = Review.all.where(user: current_user)
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to reviews_path
    else
      render 'courses/show'
    end
  end

  def destroy
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:course_id, :rating, :comment)
  end
end
