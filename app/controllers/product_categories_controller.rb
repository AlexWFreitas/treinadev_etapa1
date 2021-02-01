class ProductCategoriesController < ApplicationController
    def index
        @categories = ProductCategory.all
    end

    def new
        @category = ProductCategory.new
    end

    def create
        @category = ProductCategory.new(product_category_params)

        if @category.save
            redirect_to @category
        else
            render :new
        end
    end

    def show
        @category = ProductCategory.find(params[:id])
    end

    def edit
        @category = ProductCategory.find(params[:id])
    end

    def update
        @category = ProductCategory.find(params[:id])

        if @category.update(product_category_params)
            redirect_to @category
        else
            render :edit
        end
    end


    private

    def product_category_params
        params.require(:product_category).permit(:name, :code)
    end
end