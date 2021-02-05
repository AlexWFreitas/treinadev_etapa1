require 'rails_helper'


feature '.update' do
    scenario 'promotion gets updated' do
      Promotion.create!(name: 'Cyber Monday', coupon_quantity: 90,
                        description: 'Promoção de Cyber Monday',
                        code: 'CYBER15', discount_rate: 15,
                        expiration_date: '22/12/2033')
  
      visit root_path
      click_on 'Promoções'
      click_on 'Cyber Monday'
      click_on 'Editar'

      expect(page).to have_field('Nome', with: 'Cyber Monday')

      fill_in 'Nome', with: 'Carnaval'
      fill_in 'Descrição', with: 'Coronafest'
      fill_in 'Código', with: 'COVID21'
      fill_in 'Desconto', with: '100'
      fill_in 'Quantidade de cupons', with: '200'
      fill_in 'Data de término', with: '01/01/2022'
      click_on 'Atualizar promoção'
  
      expect(current_path).to eq(promotion_path(Promotion.last))
      expect(page).to have_content('Carnaval')
      expect(page).to have_content('Coronafest')
      expect(page).to have_content('COVID21')
      expect(page).to have_content('100')
      expect(page).to have_content('01/01/2022')
      expect(page).to have_content('200')
      expect(page).to have_link('Voltar')
    end
end
  
  
