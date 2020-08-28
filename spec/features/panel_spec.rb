# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Panel Features', type: :feature do
  let(:region) { create :region }
  let(:category) { create :category, region: region }

  before do
    sign_in_admin
    create :panel, category: category
    visit '/panels'
  end

  context 'when visiting the index page' do
    it 'shows all panels' do
      create(:panel, title: 'Second Panel', category: category)
      visit '/panels'
      expect(page).to have_content('Test Panel').and have_content('Second Panel')
    end
  end

  it 'can be edited' do
    click_on 'Edit'
    fill_in 'panel_title', with: 'New panel edited'
    click_on 'Update Panel'
    expect(page).to have_content('Panel was successfully updated')
  end

  it 'can be deleted', js: true do
    accept_confirm do
      click_on 'Delete'
    end
    expect(page).to have_content('Panel was successfully destroyed')
  end

  context 'when creating' do
    before do
      click_on 'New'
      fill_in 'panel_title', with: 'New Title'
      fill_in 'panel_short_title', with: 'New Short Title'
      fill_in 'panel_font_color', with: '#1a1844'
      fill_in 'panel_description', with: 'New panel Description'
      select category.name, from: 'panel_category_id'
    end

    it 'successfully does create' do
      click_on 'Create Panel'
      expect(page).to have_content('Panel was successfully created')
    end

    context 'when uploading an attachment' do
      it 'allows pngs' do
        attach_file('panel_avatar', file_fixture('sample.png'))
        click_on 'Create Panel'
        expect(page).to have_content('Panel was successfully created')
      end

      it 'allows jpgs' do
        attach_file('panel_avatar', file_fixture('sample.jpg'))
        click_on 'Create Panel'
        expect(page).to have_content('Panel was successfully created')
      end

      it 'does not allow other filetypes (.txt)' do
        attach_file('panel_avatar', file_fixture('sample.txt'))
        click_on 'Create Panel'
        expect(page).to have_content('Avatar is not a valid image type')
      end
    end
  end
end
