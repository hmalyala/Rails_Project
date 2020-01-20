class FavoritesController < ApplicationController

    before_action :require_signin
    before_action :set_params

    def create 
        @movie.favorites.create!(user: user_login)    

        redirect_to @movie
    end

    def destroy
        fav = user_login.favorites.find_by(params[:movie_id])            

        fav.destroy

        movie = Movie.find(params[:movie_id])

        redirect_to movie
    end

    def set_params
        @movie = Movie.find_by!(slug: params[:movie_id])
    end

end
