class UsersController < ApplicationController

    before_action :require_signin, except: [:new, :create, :show]    
    before_action :require_admin, except: [:new, :create, :show]    

    def index
        @user = User.all
    end

    def show        
        @user = User.find(params[:id])
        @reviews = @user.reviews
        @favorite_movies = @user.favorite_movies
    end

    def new 
        @user = User.new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            redirect_to @user,
            notice: "Thanks for Signing up!"
        else
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])        

        if @user.update(user_params)
            redirect_to users_path,
            notice: "Account succesfully updated"
        else
            render :edit
        end
    end

    def destroy
        @user = User.find(params[:id])
        session[:user_id] = nil
        @user.destroy
        redirect_to movies_url, alert: "Account succesfully deleted!"
    end

    private 
    
    def user_params
        params.require(:user).
            permit(:name, :email, :password, :password_confirmation)
    end
    
end
