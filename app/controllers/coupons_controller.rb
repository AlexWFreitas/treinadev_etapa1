class CouponsController < ApplicationController
    def disable_coupon
        @coupon = Coupon.find(params[:id])

        redirect_to @coupon.promotion
    end
end