class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[index show]

  def index
    @courses = Course.includes(:unit).includes(:citie, :institution)
    if params[:search]
      if params[:search][:name].present?
        @courses = @courses.where('courses.name ilike ?', "%#{params[:search][:name]}%")
      end
      if params[:search][:shift].present?
        @courses = @courses.where('courses.shift ilike ?', "%#{params[:search][:shift]}%")
      end
      if params[:search][:degree].present?
        @courses = @courses.where('courses.degree ilike ?', "%#{params[:search][:degree]}%")
      end
      if params[:search][:restaurant] == "1"
        @courses = @courses.joins(:unit).where('units.restaurant = ?', "true")
      end
      if params[:search][:accomodation] == "1"
        @courses = @courses.joins(:unit).where('units.accomodation = ?', "true")
      end
      if params[:search][:idh].present?
        @query = ["cities.idh > ? AND cities.idh < ?", 0.8, 0.899] if params[:search][:idh] == "alto"
        @query = ["cities.idh > ? AND cities.idh < ?", 0.5, 0.799] if params[:search][:idh] == "medio"
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
