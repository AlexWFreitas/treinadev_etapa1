require 'rails_helper'

feature 'Admin can view product categories' do
  scenario 'successfully' do
    # Arrange
    ProductCategory.create!( name: 'Games', code: 'games' )
    ProductCategory.create!( name: 'Roupas', code: 'clothes' )

    # Act
    visit root_path
    click_on 'Categorias'

    # Assert
    expect(page).to have_content('Games')
    expect(page).to have_content('Roupas')
  end
end

feature 'Admin can view empty product categories properly' do
  scenario 'successfully' do
    # Arrange)

    # Act
    visit root_path
    click_on 'Categorias'

    # Assert
    expect(page).to have_content('Não existe uma categoria registrada no banco de dados.')
  end
end

feature 'Admin can go back to root_path' do
  scenario 'successfully' do
    visit root_path
    click_on 'Categorias'
    click_on 'Voltar'

    expect(page).to have_content('Promotion System')
  end
end

feature 'Admin can view individual product category details' do
  scenario 'successfully' do
    ProductCategory.create!(name: 'Cozinha', code: 'cozinha')

    visit root_path
    click_on 'Categorias'
    click_on 'Cozinha'

    expect(page).to have_content('Detalhes da Categoria Cozinha')
    expect(page).to have_content('Cozinha')
    expect(page).to have_content('cozinha')
  end

  scenario 'admin can go back to product categories path' do
    ProductCategory.create!(name: 'Cozinha', code: 'cozinha')
    visit root_path
    click_on 'Categorias'
    click_on 'Cozinha'
    click_on 'Voltar para categorias'

    expect(current_path).to eq(product_categories_path)
    expect(page).to have_content('Categorias de Produto')
  end
end