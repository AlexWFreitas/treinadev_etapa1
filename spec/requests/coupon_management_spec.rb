require 'rails_helper'

describe 'Coupon management' do
    context 'GET coupon' do
        it 'should render coupon information' do
            # Arrange
            user = User.create!(email: 'alex1234@gmail.com', password: '123456')
            promotion = Promotion.create!(name: 'Carnaval', description: 'Promoção de Carnaval',
                              code: 'CARNAVAL10', discount_rate: 10,
                              coupon_quantity: 100, expiration_date: '22/12/2033', user: user)
            approver = User.create!(email: 'alex12354@gmail.com', password: '123456')
            promotion.approve!(approver)
            promotion.generate_coupons!
            coupon = promotion.coupons.last

            # Act
            get "/api/v1/coupons/#{coupon.code}"


            # Assert
            expect(response).to have_http_status(200)
            expect(response.body).to include('10')
            expect(response.body).to include('22/12/2033')
        end
    end
end