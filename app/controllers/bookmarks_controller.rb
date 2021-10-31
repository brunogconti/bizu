class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all.where(user: current_user)
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.user = current_user
    if @bookmark.save
      redirect_to bookmarks_path
    else
      # TO DO
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
