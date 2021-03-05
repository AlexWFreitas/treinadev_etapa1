class ProductCategory < ApplicationRecord
    has_many :product_category_promotions
    has_many :promotions, through: :product_category_promotions

    validates :name, :code, presence: true
    validates :code, uniqueness: true
end
