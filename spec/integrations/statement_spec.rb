# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Statement' do
  let(:region) { create :region }
  let(:category) { create :category, region: region }
  let(:panel) { create :panel, category: category }
  let(:user) { create :user }
  let(:statement) { create :statement, user: user, panel: panel }
  let!(:audio_file) { create :audio_file, statement: statement }

  it 'is associated with a user' do
    expect(statement.user).to eq(user)
  end

  it 'is associated with a audio_file' do
    expect(statement.audio_file).to eq(audio_file)
  end

  it 'is associated with a panel' do
    expect(statement.panel).to eq(panel)
  end

  context 'when created' do
    it 'has a default status of pending' do
      expect(statement.status).to eq('pending')
    end
  end

  context 'when deleted' do
    it 'receives a delete marker' do
      deleted_statement = statement.destroy!
      expect(deleted_statement.deleted_at).to be_within(1.seconds).of(Time.now)
    end
  end
end
