require 'rails_helper'

feature 'Admin re-enables a coupon' do
    scenario 'successfully' do
        user = User.create!(email: 'alex123@gmail.com', password: '123456')
        promotion = Promotion.create!(  name: 'Natal', code: 'NATAL10', description: 'Feliz Natal', coupon_quantity: 1, 
                            discount_rate: 20, expiration_date: '22/12/2033', user: user)
        coupon = Coupon.create!(code: 'ABC0001', promotion: promotion, status: 5)

        login_as user, scope: :user
        visit root_path
        click_on I18n.t ('promotions.collection_name')
        click_on promotion.name
        click_on I18n.t ('promotions.show.enable_coupon')
        
        coupon.reload.status
        expect(coupon.status).to eq('active')
    end
end