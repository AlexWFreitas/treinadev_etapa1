require 'rails_helper'

feature 'Admin disables a coupon' do
    scenario 'successfully' do
        user = User.create!(email: 'alex123@gmail.com', password: '123456')
        promotion = Promotion.create!(  name: 'Natal', code: 'NATAL10', description: 'Feliz Natal', coupon_quantity: 1, 
                            discount_rate: 20, expiration_date: '22/12/2033', user: user )
        coupon = Coupon.create!(code: 'ABC0001', promotion: promotion)

        login_as user, scope: :user
        visit root_path
        click_on I18n.t ('promotions.collection_name')
        click_on promotion.name
        click_on I18n.t ('promotions.show.disable_coupon')

        expect(page).to have_content('ABC0001 (Inativo)')
        expect(promotion.coupons.reload.active.size).to eq(0)
        coupon.reload.status
        expect(coupon.status).to eq('inactive')
    end

    scenario "disable button doesn't appear" do
        user = User.create!(email: 'alex123@gmail.com', password: '123456')
        promotion = Promotion.create!(  name: 'Natal', code: 'NATAL10', description: 'Feliz Natal', coupon_quantity: 1, 
                            discount_rate: 20, expiration_date: '22/12/2033', user: user )
        inactive_coupon = Coupon.create!(code: 'ABC0001', promotion: promotion, status: :inactive)

        active_coupon = Coupon.create!(code: 'ABC0002', promotion: promotion, status: :active)

        login_as user, scope: :user
        visit root_path
        click_on I18n.t ('promotions.collection_name')
        click_on promotion.name


        expect(page).to have_content('ABC0001 (Inativo)')
        expect(page).to have_content('ABC0002 (Ativo)')
        within("div#coupon-#{active_coupon.id}") do
            expect(page).not_to have_link(I18n.t '.promotions.show.enable_coupon')
            expect(page).to have_link(I18n.t '.promotions.show.disable_coupon')
        end

        within("div#coupon-#{inactive_coupon.id}") do
            expect(page).not_to have_link(I18n.t '.promotions.show.disable.coupon')
            expect(page).to have_link(I18n.t '.promotions.show.enable_coupon')
        end
    end
end