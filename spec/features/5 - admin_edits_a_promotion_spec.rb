require 'rails_helper'


feature 'Admin edits a promotion' do
    scenario 'promotion gets updated' do
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                        expiration_date: '22/12/2033')
  
      visit root_path
      click_on 'Promoções'
      click_on 'Natal'
      click_on 'Editar'
      fill_in 'Nome', with: 'Carnaval'
      fill_in 'Descrição', with: 'Coronafest'
      fill_in 'Código', with: 'COVID21'
      fill_in 'Desconto', with: '100'
      fill_in 'Quantidade de cupons', with: '200000'
      fill_in 'Data de término', with: '01/01/2022'
      click_on 'Editar promoção'
  
      expect(current_path).to eq(promotion_path(Promotion.last))
      expect(page).to have_content('Coronafest')
      expect(page).to have_content('COVID21')
      expect(page).to have_content('100')
      expect(page).to have_content('01/01/2022')
      expect(page).to have_content('200000')
      expect(page).to have_link('Voltar')
    end
end
  
  
