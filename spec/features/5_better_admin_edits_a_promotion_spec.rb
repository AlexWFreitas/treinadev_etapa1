require 'rails_helper'

feature 'Admin edits a promotion' do
    scenario 'promotion gets updated' do
      # Arrange 
      promotion = Promotion.create(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                        expiration_date: '22/12/2033')

      # Act
      promotion.update( :name => 'Coronaval', :description => 'Coronafest 2021',  
                        :code => 'COVID21', :discount_rate => 100, :coupon_quantity => 200000, 
                        :expiration_date => '31/12/2022' )

      # Assert
      expect(promotion.name).to eq('Coronaval')
      expect(promotion.description).to eq('Coronafest 2021')
      expect(promotion.code).to eq('COVID21')
      expect(promotion.discount_rate).to eq(100)
      expect(promotion.coupon_quantity).to eq(200000)
      expect(I18n.localize( promotion.expiration_date )).to eq('31/12/2022')
    end

    scenario 'on edit, code must be unique' do
      # Arrange
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                    expiration_date: '22/12/2033')

      Promotion.create( :name => 'Coronavaliant', :description => 'Coronafest 2022',  
                        :code => 'COVID21', :discount_rate => 150, :coupon_quantity => 200001, 
                        :expiration_date => '31/12/2026' )
      
      # Act
      promotion.update( :name => 'Coronaval', :description => 'Coronafest 2021',  
                        :code => 'COVID21', :discount_rate => 100, :coupon_quantity => 200000, 
                        :expiration_date => '31/12/2022' )

      # Assert
      expect(promotion.errors[:code]).to include('deve ser único')
    end

    scenario 'on edit, required fields should be filled' do
      # Arrange
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                    expiration_date: '22/12/2033')
      
      # Act
      promotion.update( :name => '', :description => '',  
                        :code => '', :discount_rate => '', :coupon_quantity => '', 
                        :expiration_date => '' )

      # Assert
      expect(promotion.errors[:name]).to include('não pode ficar em branco')
      expect(promotion.errors[:code]).to include('não pode ficar em branco')
      expect(promotion.errors[:discount_rate]).to include('não pode ficar em branco')
      expect(promotion.errors[:coupon_quantity]).to include('não pode ficar em branco')
      expect(promotion.errors[:expiration_date]).to include('não pode ficar em branco')
    end

    scenario 'description can be empty on update' do
      # Arrange
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                    expiration_date: '22/12/2033')
      
      # Act
      promotion.update( :name => 'Coronaval', :description => '',  
                        :code => 'COVID21', :discount_rate => 100, :coupon_quantity => 200000, 
                        :expiration_date => '31/12/2022' )

      # Assert
      expect(promotion.description).to eq('')
    end
end
  
  
