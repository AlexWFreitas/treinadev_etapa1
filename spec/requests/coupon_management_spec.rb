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
            json_response = JSON.parse(response.body, symbolize_names: true)

            # "{ code: 'bla', valor: '100'} => json_response[:code], json_response[:valor]"

            expect(response).to have_http_status(200)
            expect(json_response[:status]).to eq('active')
            expect(json_response[:promotion][:discount_rate]).to eq("10.0")
            expect(json_response[:promotion][:code]).to eq(promotion.code)
        end

        it 'should return 404 if coupon code does not exist' do
            get '/api/v1/coupons/blabla404'

            expect(response).to have_http_status(404)
        end
    end

    context 'POST coupon usage' do
        it 'should burn a coupon' do
            # post 'api/v1/coupons/blablabla/burn'
        end
        pending "Adicionar exemplo de queimação de cupom através de API"

    end
end