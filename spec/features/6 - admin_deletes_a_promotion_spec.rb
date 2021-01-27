require 'rails_helper'

describe Promotion do
  context 'When deleting an existing promotion' do
    it 'promotion gets deleted' do
      # Arrange
      promotion = Promotion.create(name: 'Natal', description: 'Promoção de Natal',
      code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
      expiration_date: '22/12/2033')

      expect( Promotion.find( promotion.id ) ).to be_an_instance_of(Promotion)

      # Act
      promotion.delete 
      
      # Assert
      expect { Promotion.find( promotion.id ) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end