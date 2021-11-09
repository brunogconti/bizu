class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[index show]

  def index
    @courses = Course.includes(:unit).includes(:citie, :institution)
    if params[:search]
      @courses = @courses.where('courses.name ilike ?', "%#{params[:search][:name]}%") if params[:search][:name].present?
      @courses = @courses.where('courses.shift ilike ?', "%#{params[:search][:shift]}%") if params[:search][:shift].present?
      if params[:search][:restaurant].present?
        @has_restaurant = params[:search][:restaurant] == 1
        @courses = @courses.joins(:unit).where('units.restaurant = ?', "#{@has_restaurant}")
      end
      if params[:search][:accomodation].present?
        @has_accomodation = params[:search][:accomodation] == 1
        @courses = @courses.joins(:unit).where('units.accomodation = ?', "#{@has_accomodation}")
      end
      if params[:search][:idh].present?
        @query = params[:search][:idh] == "alto" ? ["idh > ? OR idh < ?", 0.8, 0.899] : ["idh > ? OR idh < ?", 0.5, 0.799]
        @courses = @courses.joins(:unit).joins(:citie).where(@query)
      end
    end
    # @courses = @courses.order("#{params[:column]} #{params[:direction]}")
  end

  def show
    @course = Course.find(params[:id])
    @favorite = Bookmark.find_by(course: @course, user: current_user)
    @bookmark = Bookmark.new
    @review = Review.new
  end
end
