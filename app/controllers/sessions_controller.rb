class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
           session[:user_id] = user.id
           redirect_to user_path(user.id)
        else 
            if User.exists?(params[:session][:email].downcase)
            flash.now[:error] = "There was something wrong with your login information"
            render 'new', status: :unprocessable_entity
            else
            flash.now[:error] = "No User Found"
            render 'new', status: :unprocessable_entity
             end
        end
    end

    def destroy
        session.clear
        flash[:notice] = "You have logged out"
        redirect_to login_path
    end
end
