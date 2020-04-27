# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments Features', type: :feature do
  let(:category) { create :category }
  let(:panel) { create :panel, category: category }
  let(:organisation) { create(:organisation) }
  let(:user) { create :expert, organisation: organisation }
  let!(:statement) { create :statement, user: user, panel: panel }
  let!(:audio_file) { create :audio_file, statement: statement }
  let!(:comment_statement) { create :statement, quote: 'My comment', user: user, panel: panel }
  let!(:comment_audio_file) { create :audio_file, statement: comment_statement }
  let!(:comment) { create :comment, sender: comment_statement, recipient: statement }

  before do
    sign_in_admin
    visit '/comments'
  end

  context 'when visiting the index page' do
    it 'shows all comments' do
      st2 = create(:statement, quote: 'Second Comment', user: user, panel: panel)
      create(:audio_file, statement: st2)
      create(:comment, sender: st2, recipient: statement)
      visit '/comments'
      expect(page).to have_content('My comment').and have_content('Second Comment')
    end

    it 'does not show original statements' do
      expect(page).not_to have_content('This is my statement!')
    end

    it 'shows to which comment it belongs' do
      expect(page).to have_content(statement.id)
    end

    it 'can be directed to the original comment' do
      click_on(statement.id.to_s)
      expect(page).to have_content('Statements')
    end
  end

  it 'can be edited' do
    click_on 'Edit'
    fill_in 'statement_quote', with: 'New comment quote edited'
    select user.full_name, from: 'statement_user_id'
    select statement.id, from: 'recipient_statement_id'
    click_on 'Update Statement'
    expect(page).to have_content('Comment was successfully updated')
  end

  it 'can be deleted', js: true do
    accept_confirm do
      click_on 'Delete'
    end
    expect(page).to have_content('Comment was successfully destroyed')
  end

  context 'when creating' do
    before do
      click_on 'New'
      fill_in 'statement_quote', with: 'New Quote'
      fill_in 'statement_audio_file_attributes_file_link', with: 'http://iluvu.de/hello_its_me.mp3'
      select user.full_name, from: 'statement_user_id'
      select statement.id, from: 'recipient_statement_id'
    end

    it 'successfully does create' do
      click_on 'Create Statement'
      expect(page).to have_content('Comment was successfully created')
    end
  end

  describe 'status action' do
    it 'is possible to reject a comment' do
      click_on 'Reject'
      expect(page).to have_content('Comment was rejected.')
    end

    it 'is possible to accept a comment' do
      click_on 'Accept'
      expect(page).to have_content('Comment was accepted.')
    end
  end

  it 'is possible to create an intro for the comment' do
    click_on 'Create intro'
    expect(page).to have_content('Intro for comment was created.')
  end
end
