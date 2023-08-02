class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy ]
    before_action :require_login, only: [:edit, :update, :show ] 
    before_action :require_user, except: [:new , :create, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_admin, only: [:destroy]
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
            redirect_to user_path(@user)
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
        if current_user == @user
            current_user.destroy
            session.clear
            redirect_to root_path
            flash[:notice] = "Your account has been deleted successfully!"
        else
            @user.destroy
            redirecrt_to users_path, status: :see_other
        end
    end

    private
    def user_params
     params.require(:user).permit(:username, :email, :password)
    end

    def set_user
        if User.exists?(params[:id])
          @user = User.find(params[:id])
        else
            flash[:error] = "You must be logged in"
            redirect_to login_path
        end
    end

    def require_same_user 
        if current_user != @user and !current_user.admin?
            flash[:error] = "Not authorized!"
            redirect_to users_path
        end
    end

    def require_admin
        current_user.admin?
    end
end
