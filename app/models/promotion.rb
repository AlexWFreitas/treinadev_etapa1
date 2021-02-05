class Promotion < ApplicationRecord
    has_many :coupons

    validates :name, :code, :discount_rate, :expiration_date, :coupon_quantity, presence: true
    validates :name, :code, uniqueness: true
    validates :discount_rate, numericality: { less_than_or_equal_to: 100 }
    validates :coupon_quantity,  numericality: { less_than: 10000 }


    def generate_coupons!
        Coupon.transaction do
            #coupons.insert_all(generate_coupons_array)
            coupons.import generate_coupons_array
        end
    end

    # Method to check if there are Coupons generated
    def coupons?
        coupons.any?
    end

    def generate_coupons_array
        1.upto(coupon_quantity).inject([]) do |arr, number|
            arr << { code: "#{code}-#{'%04d' % number}", created_at: Time.current, updated_at: Time.current }
        end
    end
end
