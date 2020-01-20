class ReviewsController < ApplicationController

    before_action :require_signin, except: [:index]
    before_action :set_params

    def index
        @review = @movie.reviews
    end
    
    def new 
        @review = @movie.reviews.new
    end

    def create
        @review = @movie.reviews.new(review_params)
        @review.user = user_login
        if @review.save
            redirect_to @movie,
            notice: "Thanks for your review!"
        else
            render :new
        end
    end

    private

    def review_params
        params.require(:review).
            permit(:stars, :comment)
    end    

    def set_params
        @movie = Movie.find_by!(slug: params[:movie_id])
    end

end

