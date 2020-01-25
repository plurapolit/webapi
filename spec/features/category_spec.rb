# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category Features', type: :feature do
  before do
    sign_in_admin
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

  context 'when creating' do
    before do
      click_on 'New'
      fill_in 'category_name', with: 'New Name'
      fill_in 'category_background_color', with: '#1a1844'
    end

    it 'successfully does create' do
      click_on 'Create Category'
      expect(page).to have_content('Category was successfully created')
    end

    context 'when uploading an attachment' do
      it 'allows pngs' do
        attach_file('category_avatar', file_fixture('sample.png'))
        click_on 'Create Category'
        expect(page).to have_content('Category was successfully created')
      end

      it 'allows jpgs' do
        attach_file('category_avatar', file_fixture('sample.jpg'))
        click_on 'Create Category'
        expect(page).to have_content('Category was successfully created')
      end

      it 'does not allow other filetypes (.txt)' do
        attach_file('category_avatar', file_fixture('sample.txt'))
        click_on 'Create Category'
        expect(page).to have_content('Avatar is not a valid image type')
      end
    end
  end
end
