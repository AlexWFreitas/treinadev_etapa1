require 'rails_helper'

describe Coupon do
    describe 'associations' do
      it { should belong_to(:promotion).class_name('Promotion') }
    end

    pending "Adicionar exemplo de validação de aprovação na promoção para gerar cupom diretamente"
end
