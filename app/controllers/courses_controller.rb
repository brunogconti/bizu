class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[index show]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @bookmark = Bookmark.new
    @review = Review.new
  end
end
