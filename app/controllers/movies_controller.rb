class MoviesController < ApplicationController

    before_action :require_signin, except: [:index, :show] 
    before_action :require_admin, except: [:index, :show]

    def index
        @movies = Movie.released
    end

    def show
        @movies = Movie.find(params[:id])
        @fans = @movies.fans
    end

    def edit
        @movies = Movie.find(params[:id])
    end

    def update
        @movies = Movie.find(params[:id])
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
        @movies = Movie.find(params[:id])
        @movies.destroy
        redirect_to movies_path
    end

    private 

    def movie_params
        params.require(:movie).
        permit(:title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name)
    end
end
