require 'rails_helper'

feature 'Admin creates a category' do
    scenario 'Admin can view and fill in form fields' do
        visit root_path
        click_on 'Categorias'
        click_on 'Registrar uma categoria de produto'

        fill_in 'Categorias', with: 'Eletrodomésticos'
        fill_in 'Código', with: 'eletro'

        expect(page).to have_field('Categorias', with: 'Eletrodomésticos')
        expect(page).to have_field('Código', with: 'eletro')
    end

    scenario 'Admin can submit a new category and views the new category after submitting' do
        visit root_path
        click_on 'Categorias'
        click_on 'Registrar uma categoria de produto'

        fill_in 'Categorias', with: 'Eletrodomésticos'
        fill_in 'Código', with: 'eletro'

        click_on 'Criar categoria'

        expect(current_path).to eq(product_category_path(ProductCategory.last))
        expect(page).to have_content('Eletrodomésticos')
        expect(page).to have_content('eletro')
    end

    scenario 'Admin can submit a new category and view the categories on product_category_path' do
        ProductCategory.create!(name: 'Eletrodomésticos', code: 'eletro')
        ProductCategory.create!(name: 'Cozinha', code: 'cozinha')

        visit product_categories_path

        expect(page).to have_content('Eletrodomésticos')
        expect(page).to have_content('Cozinha')
    end
end