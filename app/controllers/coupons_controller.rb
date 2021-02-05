class CouponsController < ApplicationController
    def disable
        @coupon = Coupon.find(params[:id])
        @coupon.inactive!
        redirect_to @coupon.promotion
    end
end