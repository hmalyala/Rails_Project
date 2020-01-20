class MoviesController < ApplicationController

    before_action :require_signin, except: [:index, :show] 
    before_action :require_admin, except: [:index, :show]
    before_action :set_params, only: [:show, :edit, :update, :destroy]

    def index
        case params[:filter]
        when "upcoming"
            @movies = Movie.upcoming
        when "recent"
            @movies = Movie.recent
        else
            @movies = Movie.released
        end
    end

    def show
        @fans = @movies.fans
        @genre = @movies.genres
    end

    def edit

    end

    def update
       if @movies.update(movie_params)
            flash[:notice] = "Movie succesfully updated" 
            redirect_to @movies
       else
            render :edit
       end
    end

    def new 
        @movies = Movie.new
    end

    def create
        @movies = Movie.new(movie_params)
        if @movies.save
            redirect_to @movies
        else
            render :new
        end        
    end

    def destroy
        @movies.destroy
        redirect_to movies_path
    end  

    private 

    def movie_params
        params.require(:movie).
        permit(:title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name, genre_ids: [])
    end

    def set_params
        @movies = Movie.find_by!(slug: params[:id])
    end

end
