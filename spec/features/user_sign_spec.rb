require 'rails_helper'

feature 'User sign in do' do
    scenario 'successfully' do
        user = User.create!(email: 'alex@treinadev.com.br', password: '123456')

        visit root_path
        click_on 'Entrar'
        within('form') do
            fill_in 'Email', with: user.email
            fill_in 'Password', with: '123456'
            click_on 'Entrar'
        end

        expect(page).to have_content user.email
        expect(page).to have_content 'Login efetuado com sucesso!'
        expect(page).to have_link 'Sair'
        expect(page).not_to have_link 'Entrar'
    end
end

feature "user sign out" do
    scenario "successfully" do
        user = User.create!(email: 'alex@treinadev.com.br', password: '123456')

        visit root_path
        click_on 'Entrar'
        within('form') do
            fill_in 'Email', with: user.email
            fill_in 'Password', with: '123456'
            click_on 'Entrar'
        end
        within('nav') do
            click_on 'Sair'
        end

        within('nav') do
            expect(page).not_to have_link 'Sair'
            expect(page).not_to have_content user.email
            expect(page).to have_link 'Entrar'
        end
    end
end