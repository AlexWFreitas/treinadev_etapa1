class Promotion < ApplicationRecord
    has_many :coupons
    validates :name, :code, :discount_rate, :expiration_date, :coupon_quantity, presence: true
    validates :name, :code, uniqueness: true
    validates :discount_rate, :coupon_quantity,  numericality: true
end
