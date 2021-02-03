require 'rails_helper'

feature 'Visitor visit home page' do
  scenario 'successfully' do
    # AAA

    #Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_content(I18n.t 'home.index.title')
    expect(page).to have_content(I18n.t 'home.index.title_message')
  end
end
