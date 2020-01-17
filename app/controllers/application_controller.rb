class ApplicationController < ActionController::Base    

    private

    def require_signin
        unless user_login
            session[:intended_url] = request.url
            redirect_to new_session_url, alert: "Please sign in first!"
        end
    end

    def user_login        
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :user_login

    def require_correct_user
        @user = User.find(params[:id])
        redirect_to root_url unless current_user?(@user)
    end    
    helper_method :require_correct_user

    def current_user_admin?
        user_login && user_login.admin_user
    end
    helper_method :current_user_admin?
    

    def require_admin
        unless user_login.admin_user?
            redirect_to movies_url, alert: "Unauthorized access"
        end
    end    

end