class BookmarksController < ApplicationController
  def index
    @list = List.find(params[:list_id])
    @bookmarks = @list.bookmarks
  end

  # def new
  #   @list = List.find(params[:list_id])
  #   @bookmark = @list.bookmarks.build
  # end

  # def create
  #   @list = List.find(params[:list_id])
  #   @bookmark = @list.bookmarks.build(bookmark_params)
  #   if @bookmark.save
  #     redirect_to list_path(@list)
  #   else
  #     render :new
  #   end
  # end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      @bookmarks = @list.bookmarks
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :comment)
  end
end
