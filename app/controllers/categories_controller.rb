class CategoriesController < ApplicationController
    before_action :set_category, only: [:show , :edit , :upadte, :destroy] 
    before_action :require_user
    
    def index 
        @category = Category.all
    end

    def new
        @category = Category.new
    end

    def show 
    end

    def create 
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "Category created successfully"
            redirect_to categories_path
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def edit 
        if !current_user.admin
            flash[:error] = "Not authorized"
            redirect_to categories_path
        end
    end

    def update
          @category = Category.find(params[:id])
        if @category.update(category_params)
            redirect_to categories_path
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @category.destroy
        redirect_to categories_path, status: :see_other
    end

    def set_category
        @category = Category.find(params[:id])
    end

    private 
    def category_params
        params.require(:category).permit(:name)
    end
end