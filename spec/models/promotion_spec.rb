require 'rails_helper'

describe Promotion do
  context 'validation' do
    it 'attributes cannot be blank' do
      promotion = Promotion.new

      expect(promotion.valid?).to eq false
    end

    it 'description is optional' do
      user = User.create!(email: 'alex1234@gmail.com', password: '123456')
      promotion = Promotion.create!(name: 'Natal', description: '',
                        code: 'NATAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033', user: user)

      expect(promotion.valid?).to eq true

    end

    it 'user is required' do
      expect { Promotion.create!( name: 'Natal', description: '',
                                  code: 'NATAL10', discount_rate: 10,
                                  coupon_quantity: 100, expiration_date: '22/12/2033' ) 
              }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'error messages are in portuguese' do
      promotion = Promotion.new

      promotion.valid?

      expect(promotion.errors[:name]).to include('não pode ficar em branco')
      expect(promotion.errors[:code]).to include('não pode ficar em branco')
      expect(promotion.errors[:discount_rate]).to include('não pode ficar em '\
                                                          'branco')
      expect(promotion.errors[:coupon_quantity]).to include('não pode ficar em'\
                                                            ' branco')
      expect(promotion.errors[:expiration_date]).to include('não pode ficar em'\
                                                            ' branco')
    end

    it 'code must be uniq' do
      user = User.create!(email: 'alex1234@gmail.com', password: '123456')
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
      promotion = Promotion.new(code: 'NATAL10')

      promotion.valid?

      expect(promotion.errors[:code]).to include('deve ser único')
    end
  end

  context 'edit validation' do
    it 'promotion update cant use existing code from another promotion' do
      user = User.create!(email: 'alex1234@gmail.com', password: '123456')
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
      promotion = Promotion.create!(name: 'Carnaval', description: 'Promoção de Carnaval',
                        code: 'CARNAVAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
      promotion.update(code: 'NATAL10')

      promotion.valid?

      expect(promotion.errors[:code]).to include('deve ser único')
    end

    it 'promotion update cant use existing name from another promotion' do
      user = User.create!(email: 'alex1234@gmail.com', password: '123456')
      Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                        code: 'NATAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
      promotion = Promotion.create!(name: 'Carnaval', description: 'Promoção de Carnaval',
                        code: 'CARNAVAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
      promotion.update(name: 'Natal')

      promotion.valid?

      expect(promotion.errors[:name]).to include('deve ser único')
    end

    it 'promotion update cant have empty fields' do
      user = User.create!(email: 'alex1234@gmail.com', password: '123456')
      promotion = Promotion.create!(name: 'Carnaval', description: 'Promoção de Carnaval',
                        code: 'CARNAVAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
      promotion.update(name: '', code: '', description: '', coupon_quantity: '', expiration_date: '', discount_rate: '')

      promotion.valid?

      expect(promotion.errors[:name]).to include('não pode ficar em branco')
      expect(promotion.errors[:code]).to include('não pode ficar em branco')
      expect(promotion.errors[:discount_rate]).to include('não pode ficar em branco')
      expect(promotion.errors[:coupon_quantity]).to include('não pode ficar em branco')
      expect(promotion.errors[:expiration_date]).to include('não pode ficar em branco')
    end

    it "promotion create can't have more than 10000 coupon_quantity" do
      promotion = Promotion.create(name: 'Carnaval', description: 'Promoção de Carnaval',
      code: 'CARNAVAL10', discount_rate: 10,
      coupon_quantity: 10000, expiration_date: '22/12/2033') 

      promotion.valid?

      expect(promotion.errors[:coupon_quantity]).to include('deve ser menor que 10000')
    end
  end

  context 'update' do
    it 'after update, value is as expected' do
      user = User.create!(email: 'alex1234@gmail.com', password: '123456')
      promotion = Promotion.create!(name: 'Carnaval', description: 'Promoção de Carnaval',
                                    code: 'CARNAVAL10', discount_rate: 10,
                                    coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
      
      promotion.update(name: 'Caonaval')
      promotion.reload.name

      expect(promotion.name).to include('Caonaval')
    end
  end

  context '#generate_coupons' do
    it 'generate coupons of coupon_quantity' do
      user = User.create!(email: 'alex1234@gmail.com', password: '123456')
      promotion = Promotion.create!(name: 'Carnaval', description: 'Promoção de Carnaval',
                        code: 'CARNAVAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
      approver = User.create!(email: 'alex12354@gmail.com', password: '123456')
      promotion.approve!(approver)

      promotion.generate_coupons!

      expect(promotion.coupons.size).to eq 100
      codes = promotion.coupons.pluck(:code)
      expect(codes).to include('CARNAVAL10-0100')
      expect(codes).to include('CARNAVAL10-0001')
      expect(codes).not_to include('CARNAVAL10-0101')
      expect(codes).not_to include('CARNAVAL10-0000')
    end

    it 'do not generate if error' do
      user = User.create!(email: 'alex1234@gmail.com', password: '123456')
      promotion = Promotion.create!(name: 'Carnaval', description: 'Promoção de Carnaval',
                        code: 'CARNAVAL10', discount_rate: 10,
                        coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
      approver = User.create!(email: 'alex12354@gmail.com', password: '123456')
      promotion.approve!(approver)
      promotion.coupons.create!(code: 'CARNAVAL10-0030')

      expect { promotion.generate_coupons! }.to raise_error(ActiveRecord::RecordNotUnique)

      promotion.coupons.reload.size

      expect(promotion.coupons.size).to eq(1)
    end
  end

  context '#approve!' do
    it 'should generate a PromotionApproval object' do
      creator = User.create!(email: 'joao@email.com', password: '123456')
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                    expiration_date: '22/12/2033', user: creator)
      approval_user = User.create!(email: 'guilherme@email.com', password: '123456')

      promotion.approve!(approval_user)

      promotion.reload
      expect(promotion.approved?).to be_truthy
      expect(promotion.approver).to eq approval_user
    end

    it 'should not approve if same user' do
      creator = User.create!(email: 'joao@email.com', password: '123456')
      promotion = Promotion.create!(name: 'Natal', description: 'Promoção de Natal',
                                    code: 'NATAL10', discount_rate: 10, coupon_quantity: 100,
                                    expiration_date: '22/12/2033', user: creator)

      promotion.approve!(creator)

      promotion.reload
      expect(promotion.approved?).to be_falsy
    end
  end
end
