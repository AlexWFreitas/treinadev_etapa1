require 'rails_helper'

feature 'Admin can edit a category' do
    scenario 'Admin can edit an existing product category' do
        ProductCategory.create!(name: 'Cozinha', code: 'cozinha')

        visit root_path
        click_on 'Categorias'
        click_on 'Cozinha'
        click_on 'Editar categoria'
        fill_in 'Categorias', with: 'Eletrodomésticos'
        fill_in 'Código', with: 'eletro'
        click_on 'Atualizar categoria'

        expect(current_path).to eq(product_category_path(ProductCategory.last))
        expect(page).to have_content('Eletrodomésticos')
        expect(page).to have_content('eletro')
    end
end