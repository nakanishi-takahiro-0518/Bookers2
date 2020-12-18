class FavoritesController < ApplicationController
    before_action :authenticate_user!

    def create
        @favorite = Favorite.create(book_id: params[:book_id], user_id: current_user.id)
    end


    def destroy
        @favorite = Favorite.find_by(user_id: current_user, book_id: params[:book_id]).destroy
    end
end
