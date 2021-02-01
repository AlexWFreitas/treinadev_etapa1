require 'rails_helper'

feature 'Admin deletes a promotion' do
  scenario 'delete an existing promotion' do 
    # Arrange
    Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '22/12/2033')

    Promotion.create!(name: 'Pascoa', description: 'Promoção de Pascoa',
                      code: 'PASC10', discount_rate: 10, coupon_quantity: 100,
                      expiration_date: '24/12/2033')    
    # Act
    visit root_path
    click_on 'Promoções'
    click_on 'Natal'  
    click_on 'Deletar'
    #accept_confirm() do
    #  click_link("Deletar")
    #end

    # Assert
    expect(current_path).to eq(promotions_path)
    expect(page).to_not have_content('Natal')
    expect(page).to have_content('Pascoa')
  end
end