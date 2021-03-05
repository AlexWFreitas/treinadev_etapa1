class Promotion < ApplicationRecord
    has_many :coupons
    has_one :promotion_approval

    has_many :product_category_promotions
    has_many :product_categories, through: :product_category_promotions

    belongs_to :user

    validates :name, :code, :discount_rate, :expiration_date, :coupon_quantity, presence: true
    validates :name, :code, uniqueness: true
    validates :discount_rate, numericality: { less_than_or_equal_to: 100 }
    validates :coupon_quantity,  numericality: { less_than: 10000 }


    def generate_coupons!
        Coupon.transaction do
            coupons.insert_all!(generate_coupons_array)
            # The ActiveRecord-Import Gem adds bulk inserts method using ActiveRecord
            # if you add 'gem activerecord-import' on Gemfile
            # coupons.import generate_coupons_array
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

    # Se encontrar um promotion, então está aprovada. Se não encontrar, vai retornar nil, logo é false.
    def approved?
        promotion_approval
    end

    # Aprova o usuário
    def approve!(approval_user)
        PromotionApproval.create(promotion: self, user: approval_user)
    end

    def approved_at
        promotion_approval&.created_at
    end

    # Retorna o usuário da aprovação associada a promoção.
    def approver
        promotion_approval&.user
    end
end
