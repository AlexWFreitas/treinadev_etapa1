require 'rails_helper'


feature 'Admin edits a promotion' do
    scenario 'promotion gets updated' do
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                        expiration_date: '22/12/2033')

      promotion.update( :name => 'Coronaval', :description => 'Coronafest 2021',  
                        :code => 'COVID21', :discount_rate => 100, :coupon_quantity => 200000, 
                        :expiration_date => '31/12/2022' )

      expect(promotion.name).to eq('Coronaval')
      expect(promotion.description).to eq('Coronafest 2021')
      expect(promotion.code).to eq('COVID21')
      expect(promotion.discount_rate).to eq(100)
      expect(promotion.coupon_quantity).to eq(200000)
      expect(promotion.expiration_date.strftime("%d/%m/%Y")).to eq('31/12/2022')
    end
end
  
  
