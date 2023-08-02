class ArticlesController < ApplicationController 
    before_action :set_article , only: [:edit, :update , :show, :destroy]
    before_action :require_user, except: [:index, :show ]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def new 
        @article = Article.new 
    end
    def index 
        @article = Article.paginate(page: params[:page], :per_page => 1)
    end

    def show 
    end

    def create 
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save 
            flash[:notice] = 'Article was successfully created'
            redirect_to @article
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @article.update(article_params)
          redirect_to @article
        else
          render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy 
        @article.destroy
        redirect_to articles_path, status: :see_other
    end

    def set_article
            @article = Article.find(params[:id])
    end

    def require_same_user 
      if current_user != @article.user and !current_user.admin?
         flash[:error] = "You are not authorized Perfom this action"
         redirect_to articles_path 
      end
    end
          
private
  def article_params
    params.require(:article).permit(:title , :description, :status)
  end

end

