class Coupon < ApplicationRecord
  belongs_to :promotion

  validate :promotion_approval

  enum status: { active: 0, inactive: 5 }

  private
  def promotion_approval
    if promotion && promotion.promotion_approval == false
      errors.add(:promotion, 'Promoção não foi aprovada')
    end
  end
end
