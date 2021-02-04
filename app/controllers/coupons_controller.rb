class CouponsController < ApplicationController
    def disable
        @coupon = Coupon.find(params[:id])

        redirect_to @coupon.promotion
    end
end