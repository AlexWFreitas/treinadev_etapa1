require 'rails_helper'

feature 'Admin disables a coupon' do
    scenario 'successfully' do
        promotion = Promotion.create!(  name: 'Natal', code: 'NATAL10', description: 'Feliz Natal', coupon_quantity: 1, 
                            discount_rate: 20, expiration_date: '22/12/2033'    )
        coupon = Coupon.create!(code: 'ABC0001', promotion: promotion)

        visit root_path
        click_on I18n.t ('promotions.collection_name')
        click_on promotion.name
        click_on I18n.t ('promotions.show.disable_coupon')

        expect(page).to have_content('ABC0001 (Inativo)')
        # expect(coupon.status).to eq(:unavailable)
    end
end