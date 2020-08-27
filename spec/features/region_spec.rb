# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Region Features', type: :feature do
  before do
    sign_in_admin
    create(:region)
    visit '/regions'
  end

  context 'when visiting the index page' do
    it 'shows all regions' do
      create(:region, name: 'Second Region')
      visit '/regions'
      expect(page).to have_content('Test Region').and have_content('Second Region')
    end
  end

  it 'can be edited' do
    click_on 'Edit'
    fill_in 'region_name', with: 'New region edited'
    click_on 'Update Region'
    expect(page).to have_content('Region was successfully updated')
  end

  it 'can be deleted', js: true do
    accept_confirm do
      click_on 'Delete'
    end
    expect(page).to have_content('Region was successfully destroyed')
  end

  context 'when creating' do
    before do
      click_on 'New'
      fill_in 'region_name', with: 'New Name'
    end

    it 'successfully does create' do
      click_on 'Create Region'
      expect(page).to have_content('Region was successfully created')
    end
  end
end
