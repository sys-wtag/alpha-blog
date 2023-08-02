class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show ]
    before_action :require_login, only: [:edit, :update, :show ] 
    before_action :require_user, except: [:new , :create]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def index 
        @user = User.paginate(page: params[:page], :per_page => 5)
    end

    def new
        @user = User.new
    end

    def show 
        @user_articles = @user.articles.paginate(page: params[:page], :per_page => 1 )
    end

    def create 
        @user = User.new(user_params)
       
        if @user.save
            session[:user_id] = @user.id
            redirect_to users_path
        else
            render 'new' , status: :unprocessable_entity
        end
    end

    def edit 
    end

    def update
       
        if @user.update(user_params)
            redirect_to @user
        else
            render 'edit', status: unprocessable_entity
        end
    end
    
    def destroy
        @user.destroy
        redirect_to users_path, status: :see_other
    end

    private
    def user_params
     params.require(:user).permit(:username, :email, :password)
    end

    def set_user
          @user = User.find(params[:id])
    end

    def require_same_user 
        flash[:error] = "Not authorized!"
        redirect_to users_path if current_user != @user
    end
end
