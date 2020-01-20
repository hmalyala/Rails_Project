module FavoritesHelper

    def fave_or_unfave_button(movies)
        if user_login
            @fav = user_login.favorites.find_by(movie_id:movies.id) 
            if @fav 
                button_to "♡ Unfave", movie_favorite_path(movies), method: :delete
            else
                button_to "♥️ Fav", movie_favorites_path(movies) 
            end
       end 
    end
end
