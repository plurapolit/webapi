# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Panel Features', type: :feature do
  let(:category) { create :category }

  before do
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

  it 'can be created' do
    click_on 'New'
    fill_in 'panel_title', with: 'New Title'
    fill_in 'panel_short_title', with: 'New Short Title'
    fill_in 'panel_description', with: 'New panel Description'
    select category.name, from: 'panel_category_id'
    click_on 'Create Panel'
    expect(page).to have_content('Panel was successfully created')
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
end
