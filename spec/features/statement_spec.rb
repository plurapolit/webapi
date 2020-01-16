# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Statement Features', type: :feature do
  let(:category) { create :category }
  let(:panel) { create :panel, category: category }
  let(:organisation) { create(:organisation) }
  let(:user) { create :expert, organisation: organisation }
  let(:audio_file) { create :audio_file }

  before do
    sign_in_admin
    create :statement, user: user, panel: panel, audio_file: audio_file
    visit '/statements'
  end

  context 'when visiting the index page' do
    it 'shows all statements' do
      create(:statement, quote: 'Second Statement', user: user, panel: panel, audio_file: audio_file)
      visit '/statements'
      expect(page).to have_content('This is my statement!').and have_content('Second Statement')
    end
  end

  it 'can be edited' do
    click_on 'Edit'
    fill_in 'statement_quote', with: 'New statement quote edited'
    click_on 'Update Statement'
    expect(page).to have_content('Statement was successfully updated')
  end

  it 'can be deleted', js: true do
    accept_confirm do
      click_on 'Delete'
    end
    expect(page).to have_content('Statement was successfully destroyed')
  end

  context 'when creating' do
    before do
      click_on 'New'
      fill_in 'statement_quote', with: 'New Quote'
      select audio_file.file_link, from: 'statement_audio_file_id'
      select user.full_name, from: 'statement_user_id'
      select panel.title, from: 'statement_panel_id'
    end

    it 'successfully does create' do
      click_on 'Create Statement'
      expect(page).to have_content('Statement was successfully created')
    end
  end
end
