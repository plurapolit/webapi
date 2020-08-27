# frozen_string_literal: true

require 'rails_helper'
require 'sucker_punch/testing/inline'

RSpec.describe 'Transcription Job' do
  let(:region) { create :region }
  let(:category) { create :category, region: region }
  let(:panel) { create :panel, category: category }
  let(:organisation) { create(:organisation) }
  let(:user) { create :expert, organisation: organisation }
  let(:statement) { create :statement, user: user, panel: panel }
  let!(:audio_file) { create :audio_file, statement: statement, file_link: url }

  it 'creates a new transcription' do
    TranscriptionJob.perform_async(statement.id)
    expect(statement.transcription.present?).to be_truthy
  end

  private

  def url
    'https://plurapolit-webapi-prod-media.s3.eu-central-1.amazonaws.com/statements/Sexkaufverbot/Bauer_Sexkauf.mp3'
  end
end
