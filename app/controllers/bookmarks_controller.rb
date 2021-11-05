class BookmarksController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[index create destroy]

  def index
    @bookmarks = Bookmark.all.where(user: current_user)
  end

  def create
    @course = Course.new(params[:course_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user
    @bookmark.course = @course
    if @bookmark.save
      redirect_to bookmarks_path
    else
      render 'courses/show'
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:course_id, :comment)
  end
end
