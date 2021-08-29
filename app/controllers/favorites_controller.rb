class FavoritesController < ApplicationController
  def create
    favorite = Favorite.new(book_id: params[:book_id], user_id: current_user.id)
    favorite.save
    redirect_back(fallback_location: book_path(params[:book_id]))
  end
  
  def destroy
    favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
    favorite.destroy
    redirect_back(fallback_location: book_path(params[:book_id]))
  end
end
