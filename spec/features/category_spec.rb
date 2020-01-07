# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category Features', type: :feature do
  before do
    create(:category)
    visit '/categories'
  end

  context 'when visiting the index page' do
    it 'shows all categories' do
      create(:category, name: 'Second Category')
      visit '/categories'
      expect(page).to have_content('Test Category').and have_content('Second Category')
    end
  end

  it 'can be created' do
    click_on 'New'
    fill_in 'category_name', with: 'New category'
    click_on 'Create Category'
    expect(page).to have_content('Category was successfully created')
  end

  it 'can be edited' do
    click_on 'Edit'
    fill_in 'category_name', with: 'New category edited'
    click_on 'Update Category'
    expect(page).to have_content('Category was successfully updated')
  end

  it 'can be deleted', js: true do
    accept_confirm do
      click_on 'Delete'
    end
    expect(page).to have_content('Category was successfully destroyed')
  end
end
