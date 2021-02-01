class ProductCategoriesController < ApplicationController
    def index
        @categories = ProductCategory.all
    end
end