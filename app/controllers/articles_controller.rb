class ArticlesController < ApplicationController 
   http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

    def new 
        @article = Article.new 
    end
    def index 
        @article = Article.all
    end

    def show 
        @article = Article.find(params[:id])
    end

    def create 
        @article = Article.new(article_params)
        @article.user = User.first
        if @article.save 
            # flash[:notice] = 'Article was successfully created'
            redirect_to @article
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit 
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
    
        if @article.update(article_params)
          redirect_to @article
        else
          render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy 
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to articles_path, status: :see_other
    end
private
  def article_params
    params.require(:article).permit(:title , :description, :status)
  end

end

