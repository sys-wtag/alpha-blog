class ApplicationController < ActionController::Base
    add_flash_types :info, :error, :warning
    helper_method :current_user, :logged_in?
    # before_action :require_login

    def logged_in?
        !!current_user
    end

    def require_login
        if !logged_in?
            flash[:error] = "You must be logged in to view this path"
            redirect_to login_path
        end
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def require_user 
        if !logged_in?
            flash[:error] = "You must be logged in to perform this action"
            redirect_to login_path
        end
    end

end
