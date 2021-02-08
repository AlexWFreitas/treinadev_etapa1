require 'rails_helper'

feature 'Admin generates coupons' do
    scenario 'of a promotion' do
        # Arrange
        user = User.create!(email: 'alex123@gmail.com', password: '123456')
        promotion = Promotion.create!(  name: 'Natal', code: 'NATAL10', description: 'Feliz Natal', coupon_quantity: 100, 
                            discount_rate: 20, expiration_date: '22/12/2033', user: user)


        # Act
        login_as user, scope: :user
        visit root_path
        click_on 'Promoções'
        click_on promotion.name
        click_on 'Emitir cupons'

        # Assert
        expect(current_path).to eq(promotion_path(promotion))
        expect(page).to have_content('Cupons gerados com sucesso')
        expect(page).to have_content('NATAL10-0001')
        expect(page).to have_content('NATAL10-0002')
        expect(page).to have_content('NATAL10-0003')
        expect(page).to have_content('NATAL10-0100')
        expect(page).not_to have_content('NATAL10-0101')
        expect(page).to have_content('Cupons da promoção')
    end

    scenario 'hide button if coupons were generated' do
        user = User.create!(email: 'alex123@gmail.com', password: '123456')
        promotion = Promotion.create!(  name: 'Natal', code: 'NATAL10', description: 'Feliz Natal', coupon_quantity: 100, 
                            discount_rate: 20, expiration_date: '22/12/2033', user: user)
        
        visit root_path
        login_as user, scope: :user
        click_on 'Promoções'
        click_on promotion.name
        click_on 'Emitir cupons'

        expect(page).not_to have_link('Emitir cupons')
    end
end