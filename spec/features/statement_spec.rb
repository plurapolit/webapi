# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Statement Features', type: :feature do
  let(:category) { create :category }
  let(:panel) { create :panel, category: category }
  let(:organisation) { create(:organisation) }
  let(:user) { create :expert, organisation: organisation }
  let(:statement) { create :statement, user: user, panel: panel }
  let!(:audio_file) { create :audio_file, statement: statement }

  before do
    sign_in_admin
    visit '/statements'
  end

  context 'when visiting the index page' do
    it 'shows all statements' do
      st2 = create(:statement, quote: 'Second Statement', user: user, panel: panel)
      create(:audio_file, statement: st2)
      visit '/statements'
      expect(page).to have_content('This is my statement!').and have_content('Second Statement')
    end

    it 'does not show comments' do
      comment_statement = create(:statement, quote: 'My comment', user: user, panel: panel)
      create(:audio_file, statement: comment_statement)
      create(:comment, sender: comment_statement, recipient: statement)
      visit '/statements'
      expect(page).not_to have_content('My comment')
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
      fill_in 'audio_file_file_link', with: 'http://iluvu.de/hello_its_me.mp3'
      select user.full_name, from: 'statement_user_id'
      select panel.title, from: 'statement_panel_id'
    end

    it 'successfully does create' do
      click_on 'Create Statement'
      expect(page).to have_content('Statement was successfully created')
    end
  end

  describe 'status action' do
    it 'is possible to reject a statement' do
      click_on 'Reject'
      expect(page).to have_content('Statement was rejected.')
    end

    it 'is possible to accept a statement' do
      click_on 'Accept'
      expect(page).to have_content('Statement was accepted.')
    end
  end
end
