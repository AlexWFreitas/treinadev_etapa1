require 'rails_helper'

feature 'Admin view categories' do
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