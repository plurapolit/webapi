# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organisation Features', type: :feature do
  before do
    sign_in_admin
    create(:organisation)
    visit '/organisations'
  end

  context 'when visiting the index page' do
    it 'shows all organisations' do
      create(:organisation, name: 'Second Org')
      visit '/organisations'
      expect(page).to have_content('Test Organisation').and have_content('Second Org')
    end
  end

  it 'can be edited' do
    click_on 'Edit'
    fill_in 'organisation_name', with: 'New organisation edited'
    click_on 'Update Organisation'
    expect(page).to have_content('Organisation was successfully updated')
  end

  it 'can be deleted', js: true do
    accept_confirm do
      click_on 'Delete'
    end
    expect(page).to have_content('Organisation was successfully destroyed')
  end

  context 'when creating' do
    before do
      click_on 'New'
      fill_in 'organisation_name', with: 'New organisation'
      fill_in 'organisation_description', with: 'New description'
    end

    it 'successfully does create' do
      click_on 'Create Organisation'
      expect(page).to have_content('Organisation was successfully created')
    end

    context 'when uploading an attachment' do
      it 'allows pngs' do
        attach_file('organisation_avatar', file_fixture('sample.png'))
        click_on 'Create Organisation'
        expect(page).to have_content('Organisation was successfully created')
      end

      it 'allows jpgs' do
        attach_file('organisation_avatar', file_fixture('sample.jpg'))
        click_on 'Create Organisation'
        expect(page).to have_content('Organisation was successfully created')
      end

      it 'does not allow other filetypes (.txt)' do
        attach_file('organisation_avatar', file_fixture('sample.txt'))
        click_on 'Create Organisation'
        expect(page).to have_content('Avatar is not a valid image type')
      end
    end
  end
end
