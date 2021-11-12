class BookmarksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @bookmarks = Bookmark.where(user: current_user)
  end

  def create
    @course = Course.find(params[:course_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user
    if @bookmark.save!
      redirect_to course_path(@course), notice: 'Curso adicionado aos favoritos!'
    else
      render 'courses/show'
    end
  end

  def destroy
    if params[:course_id].present?
      @course = Course.find(params[:course_id])
      @bookmark = Bookmark.find_by(course: @course, user: current_user)
      @bookmark.destroy
      redirect_to course_path(@course), notice: 'Curso removido dos favoritos!'
    else
      @bookmark = Bookmark.find(params[:id])
      @bookmark.destroy
      redirect_to bookmarks_path, notice: 'Curso removido dos favoritos!'
    end
  end

  private

  def bookmark_params
    params.permit(:course_id, :comment)
  end
end
