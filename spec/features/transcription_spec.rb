# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transcription Features', type: :feature do
  let(:region) { create :region }
  let(:category) { create :category, region: region }
  let(:panel) { create :panel, category: category }
  let(:organisation) { create(:organisation) }
  let(:user) { create :expert, organisation: organisation }
  let(:statement) { create :statement, user: user, panel: panel }
  let!(:audio_file) { create :audio_file, statement: statement }
  let!(:transcription) { create :transcription, statement: statement }

  before do
    sign_in_admin
    visit "/transcriptions/#{transcription.id}"
  end

  it 'links to the transcription' do
    visit '/statements'
    click_link 'To transcription'
    expect(page).to have_content('I am just the content')
  end

  it 'can be edited' do
    click_link 'Edit'
    fill_in 'transcription_content', with: 'New content'
    click_on 'Update Transcription'
    expect(page).to have_content('Transcription was successfully updated')
  end

  it 'can be deleted' do
    click_link 'Delete'
    expect(page).to have_content('Transcription was successfully destroyed')
  end
end
