class PromotionsController < ApplicationController
    def new
        @promotion = Promotion.new
    end

    def index
        @promotions = Promotion.all
    end

    def show
        @promotion = Promotion.find(params[:id])
    end

    def create
        @promotion = Promotion.new(name: "...", description: "...", code: "...",  discount_rate: "...", coupon_quantity: "...", expiration_date: "...")

        if @promotion.save
            redirect_to @promotion
        else
            flash.now[:error] = "Todos campos devem ser preenchidos"
            render :new
        end
    end

end