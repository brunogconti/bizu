class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[index show]

  def index
    @courses = Course.all
    # if params[:keyword].present?
    #   sql_query = " \
    #     rooms.title @@ :query \
    #     OR rooms.description @@ :query \
    #     OR rooms.address @@ :query \
    #   "
    #   @courses = Course.where(sql_query, query: "%#{params[:keyword]}%")
    # end

    # if params[:city_size].present?
    #   @courses = @courses.where()
    # end
    # @markers = @rooms.geocoded.map do |room|
    #   {
    #     lat: room.latitude,
    #     lng: room.longitude,
    #     info_window: render_to_string(partial: "info_window", locals: { room: room }),
    #     image_url: helpers.asset_url('https://cdn4.iconfinder.com/data/icons/map-pins-2/256/15-512.png')
    #   }
    # end
  end

  def show
    @course = Course.find(params[:id])
    @favorite = Bookmark.find_by(course: @course, user: current_user)
    @bookmark = Bookmark.new
    @review = Review.new
  end
end
