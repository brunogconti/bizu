class BookmarksController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[index]

  def index
    @bookmarks = Bookmark.all.where(user: current_user)
  end

  def create
    raise
    @course = Course.find(params[:bookmark][:course_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user
    @bookmark.course = @course
    if @bookmark.save!
      redirect_to course_path(@course)
    else
      render 'courses/show'
    end
  end

  def destroy
    @course = Course.find(params[:bookmark][:course_id])
    @bookmark = Bookmark.find_by(course: @course, user: current_user)
    # @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to course_path(@course), notice: 'bookmark was successfully destroyed.'
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:course_id, :comment)
  end
end
